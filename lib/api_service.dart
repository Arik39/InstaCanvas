import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/instagram_profile_model.dart';

/// Fetches Instagram profile info with a two-tier strategy:
///   1. Direct call to Instagram's public `web_profile_info` endpoint. Free,
///      no key — works from real end-user devices on residential/mobile IPs.
///   2. If the direct call fails (rate limit / login wall / flagged IP), fall
///      back to Apify's "Instagram Profile Scraper" actor, which handles auth
///      + proxies server-side and works from any IP.
///
/// ── Setting up the Apify fallback (one-time, free, no credit card) ─────────
///   1. Create a free account at https://apify.com ($5/mo credit, ~2000
///      profiles/month, no card required).
///   2. Settings → API & Integrations → copy your Personal API token
///      (starts with `apify_api_...`).
///   3. Run the app with it injected (never hardcode):
///        flutter run --dart-define=APIFY_TOKEN=apify_api_xxx
///      If no token is provided the app simply uses the direct path only.
class ApiService {
  static const String _webProfileUrl =
      'https://www.instagram.com/api/v1/users/web_profile_info/';

  // Public web app id required by the web_profile_info endpoint.
  static const String _igAppId = '936619743392459';

  // Apify fallback (token injected at build time, never hardcoded).
  static const String _apifyToken =
      String.fromEnvironment('APIFY_TOKEN', defaultValue: '');
  static const String _apifyActorUrl =
      'https://api.apify.com/v2/acts/apify~instagram-profile-scraper/run-sync-get-dataset-items';

  static Map<String, String> get _directHeaders => {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
                '(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Accept': '*/*',
        'Accept-Language': 'en-US,en;q=0.9',
        'x-ig-app-id': _igAppId,
        'x-asbd-id': '129477',
        'x-ig-www-claim': '0',
        'x-requested-with': 'XMLHttpRequest',
        'Sec-Fetch-Site': 'same-origin',
      };

  /// Get Instagram profile information with typed response.
  static Future<InstagramProfileModel> getProfileInfo(String username) async {
    final direct = await _tryDirect(username);
    if (direct != null) return direct;

    if (_apifyToken.isNotEmpty) {
      final viaApi = await _tryApify(username);
      if (viaApi != null) return viaApi;
    }

    return InstagramProfileModel.error(
      error: _apifyToken.isEmpty
          ? 'Instagram is rate-limiting requests. Please try again later.'
          : 'Could not fetch this profile right now. Please try again.',
    );
  }

  /// Legacy map-shaped response — routes through the same fallback chain.
  static Future<Map<String, dynamic>> getProfileInfoLegacy(
      String username) async {
    final model = await getProfileInfo(username);
    if (model.success) {
      return {
        'success': true,
        'username': model.username,
        'profile_pic_url': model.profilePicUrl,
        'full_name': model.fullName,
        'follower_count': model.followerCount,
        'following_count': model.followingCount,
        'is_private': model.isPrivate,
        'is_verified': model.isVerified,
      };
    }
    return {
      'success': false,
      'error': model.error,
      'status_code': model.statusCode,
    };
  }

  /// Tier 1: direct Instagram call. Returns null on any failure so the caller
  /// can fall back.
  static Future<InstagramProfileModel?> _tryDirect(String username) async {
    try {
      final uri = Uri.parse('$_webProfileUrl?username=$username');
      final headers = {
        ..._directHeaders,
        'Referer': 'https://www.instagram.com/$username/',
      };

      var resp = await http.get(uri, headers: headers);
      if (resp.statusCode == 429) {
        await Future.delayed(const Duration(seconds: 2));
        resp = await http.get(uri, headers: headers);
      }
      if (resp.statusCode != 200) return null;

      final data = json.decode(resp.body);
      // Instagram sometimes returns 200 with a login/rate-limit wall.
      if (data is Map &&
          (data['require_login'] == true || data['status'] == 'fail')) {
        return null;
      }

      final user = data['data']?['user'];
      if (user == null) return null;

      return InstagramProfileModel.success(
        username: username,
        profilePicUrl: user['profile_pic_url_hd'] ?? user['profile_pic_url'],
        fullName: user['full_name'],
        followerCount: user['edge_followed_by']?['count'],
        followingCount: user['edge_follow']?['count'],
        isPrivate: user['is_private'],
        isVerified: user['is_verified'],
      );
    } catch (_) {
      return null;
    }
  }

  /// Tier 2: Apify "Instagram Profile Scraper" fallback. Returns null on any
  /// failure. The actor handles auth + residential proxies server-side, so it
  /// works regardless of the device IP.
  static Future<InstagramProfileModel?> _tryApify(String username) async {
    try {
      final uri = Uri.parse('$_apifyActorUrl?token=$_apifyToken');
      final resp = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'usernames': [username],
        }),
      );
      // run-sync-get-dataset-items returns 200 or 201 on success.
      if (resp.statusCode != 200 && resp.statusCode != 201) return null;

      final body = json.decode(resp.body);
      if (body is! List || body.isEmpty) return null;
      final user = body.first;
      if (user is! Map) return null;

      final pic = user['profilePicUrlHD'] ?? user['profilePicUrl'];
      if (pic == null) return null;

      return InstagramProfileModel.success(
        username: (user['username'] ?? username).toString(),
        profilePicUrl: pic.toString(),
        fullName: user['fullName']?.toString(),
        followerCount: user['followersCount'],
        followingCount: user['followsCount'],
        isPrivate: user['private'],
        isVerified: user['verified'],
      );
    } catch (_) {
      return null;
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/instagram_profile_model.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:80';

  // static Future<Map<String, dynamic>> getProfilePic(
  //     String username) async {
  //   final response = await http.get(
  //     Uri.parse(
  //         '$baseUrl/get_profile_pic?username=$username'),
  //   );

  //   if (response.statusCode == 200) {
  //     return json.decode(response.body);
  //   } else {
  //     throw Exception('Failed to load profile picture');
  //   }
  // }

  static const String _apiUrl =
      'https://i.instagram.com/api/v1/users/web_profile_info/';
  static const String _userAgent =
      'Instagram 337.0.0.0.77 Android (28/9; 420dpi; 1080x1920; samsung; SM-G611F; on7xreflte; samsungexynos7870; en_US; 493419337)';

  /// Get Instagram profile information with typed response
  static Future<InstagramProfileModel> getProfileInfo(String username) async {
    try {
      final response = await http.get(
        Uri.parse('$_apiUrl?username=$username'),
        headers: {'User-Agent': _userAgent, 'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final user = data['data']['user'];

        return InstagramProfileModel.success(
          username: username,
          profilePicUrl: user['profile_pic_url_hd'],
          fullName: user['full_name'],
          followerCount: user['follower_count'],
          followingCount: user['following_count'],
          isPrivate: user['is_private'],
          isVerified: user['is_verified'],
        );
      } else {
        return InstagramProfileModel.error(
          error: 'User not found or error occurred',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return InstagramProfileModel.error(
        error: 'Network error: $e',
      );
    }
  }

  /// Legacy method for backward compatibility
  static Future<Map<String, dynamic>> getProfileInfoLegacy(
      String username) async {
    try {
      final response = await http.get(
        Uri.parse('$_apiUrl?username=$username'),
        headers: {'User-Agent': _userAgent, 'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final user = data['data']['user'];

        return {
          'success': true,
          'username': username,
          'profile_pic_url': user['profile_pic_url_hd'],
          'full_name': user['full_name'],
          'follower_count': user['follower_count'],
          'following_count': user['following_count'],
          'is_private': user['is_private'],
          'is_verified': user['is_verified'],
        };
      } else {
        return {
          'success': false,
          'error': 'User not found or error occurred',
          'status_code': response.statusCode,
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
}

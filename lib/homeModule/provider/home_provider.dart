import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:gal/gal.dart';

import 'package:insta_canvas/common_functions.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:insta_canvas/models/instagram_profile_model.dart';

import 'package:insta_canvas/api_service.dart';
import 'package:http/http.dart' as http;

class HomeProvider extends ChangeNotifier {
  String imgUrl = '';
  String username = '';

  Uint8List? _imageBytes;
  InstagramProfileModel? _profileData;
  bool _isSaving = false;

  Uint8List? get imageBytes => _imageBytes;
  InstagramProfileModel? get profileData => _profileData;
  bool get isSaving => _isSaving;

  File? file;

  /// Save the currently fetched profile picture to the device gallery.
  Future<bool> downloadFile() async {
    if (_imageBytes == null) {
      showSnackbar("Nothing to save yet");
      return false;
    }
    try {
      _isSaving = true;
      notifyListeners();

      // gal handles the gallery permission request internally.
      if (!await Gal.hasAccess()) {
        await Gal.requestAccess();
      }

      // gal saves from a file path; write the bytes to a temp file first.
      final dir = await getTemporaryDirectory();
      final filePath = '${dir.path}/${_generateFileName(username)}';
      await File(filePath).writeAsBytes(_imageBytes!);

      await Gal.putImage(filePath, album: 'InstaCanvas');
      showSnackbar("Saved to gallery");
      return true;
    } catch (e) {
      debugPrint('Error saving to gallery: $e');
      showSnackbar("Could not save image");
      return false;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  /// Fetch Instagram profile information using the new typed model
  Future<bool> fetchProfileInfo() async {
    try {
      if (username.isEmpty) {
        showSnackbar("Please enter username");
        return false;
      }

      final profileResult = await ApiService.getProfileInfo(username);

      if (profileResult.success) {
        _profileData = profileResult;

        // Download the profile picture
        if (profileResult.profilePicUrl != null) {
          await _downloadProfilePicture(profileResult.profilePicUrl!);
        }

        notifyListeners();
        return true;
      } else {
        showSnackbar(profileResult.error ?? "Failed to fetch profile");
        return false;
      }
    } catch (e) {
      debugPrint('Error fetching profile: $e');
      showSnackbar("Something went wrong. Please try again!");
      return false;
    }
  }

  /// Download profile picture from URL into memory (and app storage cache)
  Future<void> _downloadProfilePicture(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        _imageBytes = response.bodyBytes;

        // Cache to app-private storage
        Directory? externalDir = await getExternalStorageDirectory();
        if (externalDir != null) {
          externalDir = Directory('${externalDir.path}/savedImages/');
          if (!await externalDir.exists()) {
            await externalDir.create(recursive: true);
          }
          final filePath = '${externalDir.path}${_generateFileName(username)}';
          await File(filePath).writeAsBytes(_imageBytes!);
        }
      }
    } catch (e) {
      debugPrint('Error downloading profile picture: $e');
    }
  }

  /// Legacy method for backward compatibility
  Future<bool> fetchImage() async {
    try {
      if (username.isEmpty) {
        showSnackbar("Please enter username");
        return false;
      }

      final profilePicData = await ApiService.getProfileInfoLegacy(username);

      if (profilePicData.isNotEmpty && profilePicData['success'] == true) {
        // Convert legacy response to new model
        _profileData = InstagramProfileModel.fromJson(profilePicData);

        if (profilePicData['profile_pic_url'] != null) {
          await _downloadProfilePicture(profilePicData['profile_pic_url']);
        }

        notifyListeners();
        return true;
      } else {
        if (username.contains("@")) {
          showSnackbar("Please enter username without @");
        } else {
          // Surface the real reason (rate limit, not found, network) instead
          // of always blaming the username.
          showSnackbar(profilePicData['error']?.toString() ?? "No username found");
        }
        return false;
      }
    } catch (e) {
      debugPrint('$e');
      showSnackbar("Something went wrong. Please try again!");
      return false;
    }
  }

  String _generateFileName(String username) {
    final dateFormatter = DateFormat('dd_MM_yy');
    final timeFormatter = DateFormat('HH_mm');

    final DateTime now = DateTime.now();
    final formattedDate = dateFormatter.format(now);
    final formattedTime = timeFormatter.format(now);

    if (username.contains('.')) {
      username = username.replaceAllMapped('.', (match) => ' ');
    }
    return '$username-$formattedDate-$formattedTime.jpg';
  }

  /// Get formatted follower count
  String getFormattedFollowerCount() {
    if (_profileData?.followerCount == null) return '0';

    final count = _profileData!.followerCount!;
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  /// Get formatted following count
  String getFormattedFollowingCount() {
    if (_profileData?.followingCount == null) return '0';

    final count = _profileData!.followingCount!;
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  /// Clear profile data
  void clearProfileData() {
    _profileData = null;
    _imageBytes = null;
    notifyListeners();
  }
}

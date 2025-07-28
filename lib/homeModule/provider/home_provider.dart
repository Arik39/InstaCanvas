import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:insta_canvas/common_functions.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:insta_canvas/models/instagram_profile_model.dart';

import 'package:insta_canvas/api_service.dart'; // Add this import
import 'package:http/http.dart' as http;

class HomeProvider extends ChangeNotifier {
  late String _imgUrl;
  late String username;
  double? _downloadProgress;

  Uint8List? _imageBytes;
  InstagramProfileModel? _profileData;

  Uint8List? get imageBytes => _imageBytes;
  InstagramProfileModel? get profileData => _profileData;

  String get imgUrl => _imgUrl;

  File? file;

  set imgUrl(String value) {
    _imgUrl = value;
  }

  Future<bool> downloadFile() async {
    return false;
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
      print('Error fetching profile: $e');
      showSnackbar("Something went wrong. Please try again!");
      return false;
    }
  }

  /// Download profile picture from URL
  Future<void> _downloadProfilePicture(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        _imageBytes = response.bodyBytes;

        // Save to local storage
        Directory? externalDir = await getExternalStorageDirectory();
        externalDir = Directory('${externalDir!.path}/savedImages/');
        if (!await externalDir.exists()) {
          Directory(externalDir.path).create();
        }

        String filePath = externalDir.path + _generateFileName(username);
        File imageFile = File(filePath);
        await imageFile.writeAsBytes(_imageBytes!);
      }
    } catch (e) {
      print('Error downloading profile picture: $e');
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
          showSnackbar("No username found");
        }

        throw Exception("No image Found");
      }
    } catch (e) {
      print(e);
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
    return username + "-" + formattedDate + "-" + formattedTime + ".jpg";
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

import 'package:flutter/material.dart';
import 'instagram_profile_model.dart';
import '../api_service.dart';
import '../flutter_instagram_api.dart';

/// Example usage of InstagramProfileModel
class InstagramProfileExample {
  /// Example 1: Basic usage with ApiService
  static Future<void> basicUsage() async {
    try {
      final profile = await ApiService.getProfileInfo('instagram');

      if (profile.success) {
        print('Username: ${profile.username}');
        print('Full Name: ${profile.fullName}');
        print('Followers: ${profile.followerCount}');
        print('Following: ${profile.followingCount}');
        print('Profile Pic: ${profile.profilePicUrl}');
        print('Is Private: ${profile.isPrivate}');
        print('Is Verified: ${profile.isVerified}');
      } else {
        print('Error: ${profile.error}');
        print('Status Code: ${profile.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  /// Example 2: Using InstagramProfileService
  static Future<void> usingInstagramService() async {
    try {
      final profile = await InstagramProfileService.getProfileInfo('cristiano');

      if (profile.success) {
        print('Profile found for: ${profile.fullName}');
        print('Followers: ${_formatNumber(profile.followerCount)}');
        print('Following: ${_formatNumber(profile.followingCount)}');
      } else {
        print('Failed to fetch profile: ${profile.error}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  /// Example 3: Creating model instances manually
  static void createModelInstances() {
    // Success case
    final successProfile = InstagramProfileModel.success(
      username: 'example_user',
      profilePicUrl: 'https://example.com/profile.jpg',
      fullName: 'Example User',
      followerCount: 1000,
      followingCount: 500,
      isPrivate: false,
      isVerified: true,
    );

    // Error case
    final errorProfile = InstagramProfileModel.error(
      error: 'User not found',
      statusCode: 404,
    );

    // From JSON
    final jsonData = {
      'success': true,
      'username': 'test_user',
      'profile_pic_url': 'https://example.com/test.jpg',
      'full_name': 'Test User',
      'follower_count': 500,
      'following_count': 200,
      'is_private': false,
      'is_verified': false,
    };

    final fromJsonProfile = InstagramProfileModel.fromJson(jsonData);

    print('Success Profile: $successProfile');
    print('Error Profile: $errorProfile');
    print('From JSON Profile: $fromJsonProfile');
  }

  /// Example 4: Using in a Flutter widget
  static Widget buildProfileCard(InstagramProfileModel profile) {
    if (!profile.success) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Error: ${profile.error}',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (profile.profilePicUrl != null)
                  CircleAvatar(
                    backgroundImage: NetworkImage(profile.profilePicUrl!),
                    radius: 30,
                  ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.fullName ?? 'Unknown',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '@${profile.username}',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                if (profile.isVerified == true)
                  const Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: 20,
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  'Followers',
                  _formatNumber(profile.followerCount),
                ),
                _buildStatItem(
                  'Following',
                  _formatNumber(profile.followingCount),
                ),
              ],
            ),
            if (profile.isPrivate == true)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.lock, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      'Private Account',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Example 5: Batch processing multiple profiles
  static Future<List<InstagramProfileModel>> fetchMultipleProfiles(
    List<String> usernames,
  ) async {
    final List<InstagramProfileModel> profiles = [];

    for (final username in usernames) {
      try {
        final profile = await ApiService.getProfileInfo(username);
        profiles.add(profile);
      } catch (e) {
        profiles.add(InstagramProfileModel.error(
          error: 'Failed to fetch $username: $e',
        ));
      }
    }

    return profiles;
  }

  /// Example 6: Filtering and sorting profiles
  static List<InstagramProfileModel> filterAndSortProfiles(
    List<InstagramProfileModel> profiles,
  ) {
    // Filter only successful profiles
    final successfulProfiles =
        profiles.where((profile) => profile.success).toList();

    // Sort by follower count (descending)
    successfulProfiles.sort((a, b) {
      final aFollowers = a.followerCount ?? 0;
      final bFollowers = b.followerCount ?? 0;
      return bFollowers.compareTo(aFollowers);
    });

    return successfulProfiles;
  }

  /// Helper method to format numbers
  static String _formatNumber(int? number) {
    if (number == null) return '0';

    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  /// Helper method to build stat items
  static Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

/// Example usage in a StatefulWidget
class ProfileExampleWidget extends StatefulWidget {
  const ProfileExampleWidget({super.key});

  @override
  State<ProfileExampleWidget> createState() => _ProfileExampleWidgetState();
}

class _ProfileExampleWidgetState extends State<ProfileExampleWidget> {
  InstagramProfileModel? _profile;
  bool _isLoading = false;

  Future<void> _fetchProfile(String username) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final profile = await ApiService.getProfileInfo(username);
      setState(() {
        _profile = profile;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _profile = InstagramProfileModel.error(error: e.toString());
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _fetchProfile('instagram'),
              child: const Text('Fetch Instagram Profile'),
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_profile != null)
              InstagramProfileExample.buildProfileCard(_profile!)
            else
              const Text('No profile loaded'),
          ],
        ),
      ),
    );
  }
}

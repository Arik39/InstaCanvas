# Instagram Profile Model

This directory contains the data models for Instagram profile information.

## InstagramProfileModel

A comprehensive model for Instagram profile data returned by the `getProfileInfo` API method.

### Features

- **Type Safety**: All fields are properly typed with null safety
- **JSON Serialization**: Built-in `fromJson` and `toJson` methods
- **Factory Constructors**: Convenient constructors for success and error cases
- **Equality & Hash Code**: Proper implementation for collections and comparisons
- **Copy With**: Immutable updates with `copyWith` method

### Fields

| Field            | Type      | Description                             |
| ---------------- | --------- | --------------------------------------- |
| `success`        | `bool`    | Whether the API call was successful     |
| `username`       | `String?` | Instagram username                      |
| `profilePicUrl`  | `String?` | URL to the profile picture (HD quality) |
| `fullName`       | `String?` | User's full name                        |
| `followerCount`  | `int?`    | Number of followers                     |
| `followingCount` | `int?`    | Number of accounts being followed       |
| `isPrivate`      | `bool?`   | Whether the account is private          |
| `isVerified`     | `bool?`   | Whether the account is verified         |
| `error`          | `String?` | Error message (if any)                  |
| `statusCode`     | `int?`    | HTTP status code (if error)             |

### Usage Examples

#### Basic Usage

```dart
import 'package:insta_canvas/models/instagram_profile_model.dart';
import 'package:insta_canvas/api_service.dart';

// Fetch profile data
final profile = await ApiService.getProfileInfo('instagram');

if (profile.success) {
  print('Username: ${profile.username}');
  print('Full Name: ${profile.fullName}');
  print('Followers: ${profile.followerCount}');
  print('Profile Pic: ${profile.profilePicUrl}');
} else {
  print('Error: ${profile.error}');
}
```

#### Creating Instances

```dart
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
final fromJsonProfile = InstagramProfileModel.fromJson(jsonData);
```

#### Using in Widgets

```dart
Widget buildProfileCard(InstagramProfileModel profile) {
  if (!profile.success) {
    return Card(
      child: Text('Error: ${profile.error}'),
    );
  }

  return Card(
    child: Column(
      children: [
        Text(profile.fullName ?? 'Unknown'),
        Text('@${profile.username}'),
        Text('${profile.followerCount} followers'),
        if (profile.isVerified == true)
          Icon(Icons.verified, color: Colors.blue),
      ],
    ),
  );
}
```

### API Service Integration

The model is integrated with both `ApiService` and `InstagramProfileService`:

```dart
// Using ApiService (recommended)
final profile = await ApiService.getProfileInfo('username');

// Using InstagramProfileService
final profile = await InstagramProfileService.getProfileInfo('username');
```

### Legacy Support

For backward compatibility, legacy methods are still available:

```dart
// Legacy method returns Map<String, dynamic>
final legacyResult = await ApiService.getProfileInfoLegacy('username');

// Convert to model
final profile = InstagramProfileModel.fromJson(legacyResult);
```

### Helper Methods

The model includes several helper methods:

- `copyWith()`: Create a new instance with updated fields
- `toString()`: String representation for debugging
- `==` and `hashCode`: Proper equality comparison

### Error Handling

The model handles both success and error cases gracefully:

```dart
final profile = await ApiService.getProfileInfo('nonexistent_user');

if (profile.success) {
  // Handle success case
} else {
  // Handle error case
  print('Error: ${profile.error}');
  print('Status Code: ${profile.statusCode}');
}
```

### Migration Guide

If you're migrating from the old Map-based approach:

**Old Code:**

```dart
final result = await ApiService.getProfileInfo('username');
if (result['success']) {
  final username = result['username'];
  final followers = result['follower_count'];
}
```

**New Code:**

```dart
final profile = await ApiService.getProfileInfo('username');
if (profile.success) {
  final username = profile.username;
  final followers = profile.followerCount;
}
```

### Benefits

1. **Type Safety**: No more runtime errors from accessing non-existent keys
2. **IntelliSense**: Better IDE support with autocomplete
3. **Maintainability**: Easier to refactor and update
4. **Documentation**: Self-documenting code with clear field names
5. **Testing**: Easier to write unit tests with proper models

### Files

- `instagram_profile_model.dart`: Main model class
- `example_usage.dart`: Comprehensive usage examples
- `README.md`: This documentation file

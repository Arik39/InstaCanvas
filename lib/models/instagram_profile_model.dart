class InstagramProfileModel {
  final bool success;
  final String? username;
  final String? profilePicUrl;
  final String? fullName;
  final int? followerCount;
  final int? followingCount;
  final bool? isPrivate;
  final bool? isVerified;
  final String? error;
  final int? statusCode;

  InstagramProfileModel({
    required this.success,
    this.username,
    this.profilePicUrl,
    this.fullName,
    this.followerCount,
    this.followingCount,
    this.isPrivate,
    this.isVerified,
    this.error,
    this.statusCode,
  });

  factory InstagramProfileModel.fromJson(Map<String, dynamic> json) {
    return InstagramProfileModel(
      success: json['success'] ?? false,
      username: json['username'],
      profilePicUrl: json['profile_pic_url'],
      fullName: json['full_name'],
      followerCount: json['follower_count'],
      followingCount: json['following_count'],
      isPrivate: json['is_private'],
      isVerified: json['is_verified'],
      error: json['error'],
      statusCode: json['status_code'],
    );
  }

  factory InstagramProfileModel.success({
    required String username,
    String? profilePicUrl,
    String? fullName,
    int? followerCount,
    int? followingCount,
    bool? isPrivate,
    bool? isVerified,
  }) {
    return InstagramProfileModel(
      success: true,
      username: username,
      profilePicUrl: profilePicUrl,
      fullName: fullName,
      followerCount: followerCount,
      followingCount: followingCount,
      isPrivate: isPrivate,
      isVerified: isVerified,
    );
  }

  factory InstagramProfileModel.error({
    required String error,
    int? statusCode,
  }) {
    return InstagramProfileModel(
      success: false,
      error: error,
      statusCode: statusCode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'username': username,
      'profile_pic_url': profilePicUrl,
      'full_name': fullName,
      'follower_count': followerCount,
      'following_count': followingCount,
      'is_private': isPrivate,
      'is_verified': isVerified,
      'error': error,
      'status_code': statusCode,
    };
  }

  @override
  String toString() {
    return 'InstagramProfileModel(success: $success, username: $username, fullName: $fullName, followerCount: $followerCount, followingCount: $followingCount, isPrivate: $isPrivate, isVerified: $isVerified, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InstagramProfileModel &&
        other.success == success &&
        other.username == username &&
        other.profilePicUrl == profilePicUrl &&
        other.fullName == fullName &&
        other.followerCount == followerCount &&
        other.followingCount == followingCount &&
        other.isPrivate == isPrivate &&
        other.isVerified == isVerified &&
        other.error == error &&
        other.statusCode == statusCode;
  }

  @override
  int get hashCode {
    return success.hashCode ^
        username.hashCode ^
        profilePicUrl.hashCode ^
        fullName.hashCode ^
        followerCount.hashCode ^
        followingCount.hashCode ^
        isPrivate.hashCode ^
        isVerified.hashCode ^
        error.hashCode ^
        statusCode.hashCode;
  }

  InstagramProfileModel copyWith({
    bool? success,
    String? username,
    String? profilePicUrl,
    String? fullName,
    int? followerCount,
    int? followingCount,
    bool? isPrivate,
    bool? isVerified,
    String? error,
    int? statusCode,
  }) {
    return InstagramProfileModel(
      success: success ?? this.success,
      username: username ?? this.username,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      fullName: fullName ?? this.fullName,
      followerCount: followerCount ?? this.followerCount,
      followingCount: followingCount ?? this.followingCount,
      isPrivate: isPrivate ?? this.isPrivate,
      isVerified: isVerified ?? this.isVerified,
      error: error ?? this.error,
      statusCode: statusCode ?? this.statusCode,
    );
  }
}

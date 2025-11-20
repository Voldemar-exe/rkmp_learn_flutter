class ProfileEntity {
  final String username;
  final String? profileIconName;

  ProfileEntity({
    required this.username,
    this.profileIconName,
  });

  ProfileEntity copyWith({
    String? username,
    String? profileIconName
  }) {
    return ProfileEntity(
      username: username ?? this.username,
      profileIconName: profileIconName ?? this.profileIconName,
    );
  }
}
class ProfileEntity {
  final String username;
  final int goal;
  final String? profileIconName;

  ProfileEntity({
    required this.username,
    required this.goal,
    this.profileIconName,
  });

  ProfileEntity copyWith({
    String? username,
    int? goal,
    String? profileIconName
  }) {
    return ProfileEntity(
      username: username ?? this.username,
      goal: goal ?? this.goal,
      profileIconName: profileIconName ?? this.profileIconName,
    );
  }
}
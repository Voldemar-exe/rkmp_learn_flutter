class Profile {
  final String username;
  final String profileIconName;

  Profile({
    required this.username,
    required this.profileIconName,
  });

  Profile copyWith({
    String? username,
    int? goal,
    String? profileIconName,
  }) {
    return Profile(
      username: username ?? this.username,
      profileIconName: profileIconName ?? this.profileIconName,
    );
  }
}
class User {
  final String username;
  final int goal;

  User({
    required this.username,
    required this.goal,
  });

  User copyWith({
    String? username,
    int? goal,
  }) {
    return User(
      username: username ?? this.username,
      goal: goal ?? this.goal,
    );
  }
}
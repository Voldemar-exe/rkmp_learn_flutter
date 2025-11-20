import 'package:rkmp_learn_flutter/features/profile/domain/entities/profile_entity.dart';

class Profile extends ProfileEntity {
  Profile({
    required super.username,
    required super.goal,
    super.profileIconName,
  });

  static Profile fromEntity(ProfileEntity entity) {
    return Profile(
      username: entity.username,
      goal: entity.goal,
      profileIconName: entity.profileIconName,
    );
  }

  ProfileEntity toEntity() {
    return ProfileEntity(
      username: username,
      goal: goal,
      profileIconName: profileIconName,
    );
  }

  @override
  Profile copyWith({
    String? username,
    int? goal,
    String? profileIconName,
  }) {
    return Profile(
      username: username ?? this.username,
      goal: goal ?? this.goal,
      profileIconName: profileIconName ?? this.profileIconName,
    );
  }
}
import 'package:rkmp_learn_flutter/features/profile/domain/entities/profile_entity.dart';

class ProfileLocalDataSource {
  static final Map<String, dynamic> _storage = {
    'username': 'Jonny John',
    'profile_icon_name': 'person',
  };

  Future<ProfileEntity> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 100));

    return ProfileEntity(
      username: _storage['username'] as String,
      profileIconName: _storage['profile_icon_name'] as String?,
    );
  }

  Future<void> saveProfile(ProfileEntity profile) async {
    await Future.delayed(const Duration(milliseconds: 100));

    _storage['username'] = profile.username;
    _storage['profile_icon_name'] = profile.profileIconName;
  }

  Future<void> updateProfileIcon(String iconName) async {
    await Future.delayed(const Duration(milliseconds: 100));

    _storage['profile_icon_name'] = iconName;
  }
}
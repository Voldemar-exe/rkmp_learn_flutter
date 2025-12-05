import 'package:shared_preferences/shared_preferences.dart';
import 'package:rkmp_learn_flutter/features/profile/domain/entities/profile_entity.dart';

class ProfileLocalDataSource {
  static const _usernameKey = 'profile_username';
  static const _iconNameKey = 'profile_icon_name';

  final SharedPreferencesAsync _prefs;

  ProfileLocalDataSource(this._prefs);

  Future<ProfileEntity> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 100));

    final username = await _prefs.getString(_usernameKey) ?? 'Jonny John';
    final iconName = await _prefs.getString(_iconNameKey);

    return ProfileEntity(
      username: username,
      profileIconName: iconName,
    );
  }

  Future<void> saveProfile(ProfileEntity profile) async {
    await Future.delayed(const Duration(milliseconds: 100));

    await _prefs.setString(_usernameKey, profile.username);
    if (profile.profileIconName != null) {
      await _prefs.setString(_iconNameKey, profile.profileIconName!);
    } else {
      await _prefs.remove(_iconNameKey);
    }
  }
}
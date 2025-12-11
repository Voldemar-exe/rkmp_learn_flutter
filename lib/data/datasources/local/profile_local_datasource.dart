import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/models/profile.dart';
import 'dto/prefs_profile_dto.dart';

class ProfileLocalDataSource {
  final SharedPreferencesAsync _prefs;

  ProfileLocalDataSource(this._prefs);

  Future<Profile> getProfile() async {
    final username = await _prefs.getString('username') ?? 'Jonny John';
    final iconName = await _prefs.getString('icon_name');

    final dto = PrefsProfileDto(username: username, icon_name: iconName);
    return dto.toModel();
  }

  Future<void> saveProfile(Profile profile) async {
    final dto = PrefsProfileDto.fromModel(profile);
    await _prefs.setString('username', dto.username);
    if (dto.icon_name != null) {
      await _prefs.setString('icon_name', dto.icon_name!);
    }
  }
}

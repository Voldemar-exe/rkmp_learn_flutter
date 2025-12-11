import '../../../core/models/profile.dart';

class ProfileApiDataSource {
  static final List<Map<String, dynamic>> _profiles = [
    {
      'id': '1',
      'userId': '1',
      'username': 'Jonny John',
      'profile_icon_name': 'person',
      'created_at': DateTime.now().toIso8601String(),
    },
    {
      'id': '2',
      'userId': '2',
      'username': 'Jane Smith',
      'profile_icon_name': 'account_circle',
      'created_at': DateTime.now().toIso8601String(),
    },
  ];

  Future<Profile?> getProfileById(int userId) async {
    try {
      final profile = _profiles.firstWhere((p) => p['userId'] == userId.toString());
      return Profile(
        username: profile['username'],
        profileIconName: profile['profile_icon_name'],
      );
    } catch (e) {
      return null;
    }
  }

  Future<bool> addProfile(String login, int userId) async {
    try {
      _profiles.add({
        'id': (_profiles.length + 1).toString(),
        'userId': userId.toString(),
        'username': login,
        'profile_icon_name': 'person',
        'created_at': DateTime.now().toIso8601String(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> deleteProfile(int userId) async {
    _profiles.removeWhere((p) => p['userId'] == userId.toString());
  }

  Future<void> saveProfile(Profile profile, int userId) async {
    final index = _profiles.indexWhere((p) => p['userId'] == userId.toString());

    if (index == -1) {
      _profiles.add({
        'id': (_profiles.length + 1).toString(),
        'userId': userId.toString(),
        'username': profile.username,
        'profile_icon_name': profile.profileIconName,
        'created_at': DateTime.now().toIso8601String(),
      });
    } else {
      _profiles[index] = {
        'id': _profiles[index]['id'],
        'userId': userId.toString(),
        'username': profile.username,
        'profile_icon_name': profile.profileIconName,
        'updated_at': DateTime.now().toIso8601String(),
      };
    }
  }
}
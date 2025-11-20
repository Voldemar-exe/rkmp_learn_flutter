import 'package:rkmp_learn_flutter/features/profile/domain/entities/profile_entity.dart';

class ProfileRemoteDataSource {
  static final List<Map<String, dynamic>> _profiles = [
    {
      'id': '1',
      'userId': '1',
      'username': 'Jonny John',
      'goal': 10,
      'profile_icon_name': 'person',
      'created_at': DateTime.now().toIso8601String(),
    },
    {
      'id': '2',
      'userId': '2',
      'username': 'Jane Smith',
      'goal': 5,
      'profile_icon_name': 'account_circle',
      'created_at': DateTime.now().toIso8601String(),
    },
  ];

  Future<ProfileEntity?> getProfileById(int userId) async {
    try {
      final profile = _profiles.firstWhere((p) => p['userId'] == userId.toString());
      return ProfileEntity(
        username: profile['username'],
        goal: profile['goal'],
        profileIconName: profile['profile_icon_name'],
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> saveProfile(ProfileEntity profile, int userId) async {
    final index = _profiles.indexWhere((p) => p['userId'] == userId.toString());

    if (index == -1) {
      _profiles.add({
        'id': (_profiles.length + 1).toString(),
        'userId': userId.toString(),
        'username': profile.username,
        'goal': profile.goal,
        'profile_icon_name': profile.profileIconName,
        'created_at': DateTime.now().toIso8601String(),
      });
    } else {
      _profiles[index] = {
        'id': _profiles[index]['id'],
        'userId': userId.toString(),
        'username': profile.username,
        'goal': profile.goal,
        'profile_icon_name': profile.profileIconName,
        'updated_at': DateTime.now().toIso8601String(),
      };
    }
  }

  Future<void> updateProfileIcon(String iconName, int userId) async {
    final index = _profiles.indexWhere((p) => p['userId'] == userId.toString());
    if (index != -1) {
      _profiles[index]['profile_icon_name'] = iconName;
    }
  }
}
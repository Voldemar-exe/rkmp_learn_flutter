import '../../../core/models/profile.dart';

abstract class ProfileRepository {
  Future<Profile> getProfile({int userId});
  Future<void> saveProfile(Profile profile, {int userId});
}

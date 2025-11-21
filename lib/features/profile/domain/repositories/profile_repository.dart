import 'package:rkmp_learn_flutter/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getProfile(int userId);
  Future<void> saveProfile(ProfileEntity profile, int userId);
}
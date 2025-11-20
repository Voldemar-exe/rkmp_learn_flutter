import 'package:rkmp_learn_flutter/features/profile/data/data_sources/local/profile_local_data_source.dart';
import 'package:rkmp_learn_flutter/features/profile/data/data_sources/remote/profile_remote_data_source.dart';
import 'package:rkmp_learn_flutter/features/profile/domain/entities/profile_entity.dart';
import 'package:rkmp_learn_flutter/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource _localDataSource;
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl({
    required ProfileRemoteDataSource remoteDataSource,
    required ProfileLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<ProfileEntity> getProfile(int userId) async {
    try {
      final remoteProfile = await _remoteDataSource.getProfileById(userId);
      if (remoteProfile != null) {
        await _localDataSource.saveProfile(remoteProfile);
        return remoteProfile;
      }

      return await _localDataSource.getProfile();
    } catch (e) {
      return ProfileEntity(
        username: 'Guest',
        profileIconName: 'person',
      );
    }
  }

  @override
  Future<void> saveProfile(ProfileEntity profile, int userId) async {
    await _localDataSource.saveProfile(profile);
    await _remoteDataSource.saveProfile(profile, userId);
  }

  @override
  Future<void> updateProfileIcon(String iconName, int userId) async {
    await _localDataSource.updateProfileIcon(iconName);
    await _remoteDataSource.updateProfileIcon(iconName, userId);
  }
}

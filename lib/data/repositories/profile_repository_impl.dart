import '../../core/models/profile.dart';
import '../../domain/interfaces/repositories/profile_repository.dart';
import '../datasources/api/profile_api_data_source.dart';
import '../datasources/local/profile_local_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource _localDataSource;
  final ProfileApiDataSource _remoteDataSource;

  ProfileRepositoryImpl({
    required ProfileApiDataSource remoteDataSource,
    required ProfileLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<Profile> getProfile(int userId) async {
    try {
      final remoteProfile = await _remoteDataSource.getProfileById(userId);
      if (remoteProfile != null) {
        await _localDataSource.saveProfile(remoteProfile);
        return remoteProfile;
      }

      return await _localDataSource.getProfile();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> saveProfile(Profile profile, int userId) async {
    await _localDataSource.saveProfile(profile);
    await _remoteDataSource.saveProfile(profile, userId);
  }
}

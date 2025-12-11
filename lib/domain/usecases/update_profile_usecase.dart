import '../../core/models/profile.dart';
import '../interfaces/repositories/auth_repository.dart';

abstract class ProfileDataSource {
  Future<Profile> getProfile();
  Future<void> saveProfile(Profile profile);
}

class UpdateProfileUseCase {
  final ProfileDataSource dataSource;

  UpdateProfileUseCase(this.dataSource);

  Future<Profile> execute({
    String? newUsername,
    String? newIcon,
  }) async {
    final currentProfile = await dataSource.getProfile();
    Profile updatedProfile = currentProfile;

    if (newUsername != null && newUsername != currentProfile.username) {
      try {
        updatedProfile = updatedProfile.copyWith(username: newUsername);
      } catch (e) {
        throw UpdateProfileException('Invalid username');
      }
    }

    if (newIcon != null && newIcon != currentProfile.profileIconName) {
      try {
        updatedProfile = updatedProfile.copyWith(profileIconName: newIcon);
      } catch (e) {
        throw UpdateProfileException('Invalid icon');
      }
    }

    await dataSource.saveProfile(updatedProfile);

    return updatedProfile;
  }
}

class UpdateProfileException implements Exception {
  final String message;
  const UpdateProfileException(this.message);

  @override
  String toString() => 'UpdateProfileException: $message';
}


class DeleteProfileUseCase {
  final AuthRepository _repository;

  DeleteProfileUseCase(this._repository);

  Future<void> execute() async {
    final user = await _repository.checkAuthStatus();
    await _repository.deleteProfile(user!.id);
  }
}
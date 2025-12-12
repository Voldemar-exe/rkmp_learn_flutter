import '../../core/models/profile.dart';
import '../interfaces/repositories/profile_repository.dart';

class SaveProfileUseCase {
  final ProfileRepository profileRepository;

  SaveProfileUseCase(this.profileRepository);

  Future<void> execute(String newUsername, {String? newIcon}) async {
    final newProfile = Profile(
      username: newUsername,
      profileIconName: newIcon ?? 'person',
    );
    await profileRepository.saveProfile(newProfile);
  }
}

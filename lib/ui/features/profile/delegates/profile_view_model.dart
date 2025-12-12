import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/profile.dart';
import '../../../../domain/interfaces/repositories/profile_repository.dart';
import '../../../shared/providers/auth_notifier.dart';
import '../../../shared/states/auth_state.dart';
import 'states/profile_state.dart';

part 'profile_view_model.g.dart';

@riverpod
class ProfileViewModel extends _$ProfileViewModel {
  late final ProfileRepository _profileRepository;

  @override
  Future<ProfileState> build() async {
    _profileRepository = GetIt.I<ProfileRepository>();
    final profileState = await _loadProfile();
    return profileState;
  }

  Future<ProfileState> _loadProfile() async {
    try {
      final profile = await _profileRepository.getProfile();

      return ProfileState(profile: profile, isLoading: false, isError: false);
    } catch (e) {
      return ProfileState(isLoading: false, isError: true);
    }
  }

  Future<void> updateProfile(Profile profile) async {
    state = const AsyncValue.loading();

    try {
      final user = await ref.read(checkAuthStatusProvider.future);
      final userId = (user as Authenticated).user.id;
      await _profileRepository.saveProfile(profile, userId: userId);

      state = AsyncValue.data(
        ProfileState(profile: profile, isLoading: false, isError: false),
      );
    } catch (e) {
      state = AsyncValue.data(
        const ProfileState(isLoading: false, isError: true),
      );
    }
  }

  Future<void> updateUsername(String username) async {
    if (state.hasValue && state.value!.profile != null) {
      final currentProfile = state.value!.profile!;
      final updatedProfile = currentProfile.copyWith(username: username);
      await updateProfile(updatedProfile);
    }
  }

  Future<void> updateProfileIcon(String iconName) async {
    if (state.hasValue && state.value!.profile != null) {
      final currentProfile = state.value!.profile!;
      final updatedProfile = currentProfile.copyWith(profileIconName: iconName);
      await updateProfile(updatedProfile);
    }
  }
}

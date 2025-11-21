import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rkmp_learn_flutter/features/auth/presentation/store/auth_view_model.dart';
import 'package:rkmp_learn_flutter/features/profile/data/models/profile.dart';
import 'package:rkmp_learn_flutter/features/profile/domain/repositories/profile_repository.dart';
import 'package:rkmp_learn_flutter/features/profile/presentation/states/profile_state.dart';
import 'package:rkmp_learn_flutter/shared/presentation/providers/auth_notifier.dart';
import 'package:rkmp_learn_flutter/shared/presentation/states/auth_state.dart';

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
      final userId = (ref.read(authProvider) as Authenticated).user.id;
      final entity = await _profileRepository.getProfile(userId);
      final model = Profile.fromEntity(entity);

      return ProfileState(
        profile: model,
        isLoading: false,
        isError: false,
      );
    } catch (e) {
      return ProfileState(
        isLoading: false,
        isError: true,
      );
    }
  }

  Future<void> updateProfile(Profile profile) async {
    state = const AsyncValue.loading();

    try {
      final userId = (ref.read(authProvider) as Authenticated).user.id;
      await _profileRepository.saveProfile(profile.toEntity(), userId);

      state = AsyncValue.data(
          ProfileState(
            profile: profile,
            isLoading: false,
            isError: false,
          )
      );
    } catch (e) {
      state = AsyncValue.data(
          const ProfileState(
            isLoading: false,
            isError: true,
          )
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

  Future<void> updateGoal(int goal) async {
    if (state.hasValue && state.value!.profile != null) {
      final currentProfile = state.value!.profile!;
      final updatedProfile = currentProfile.copyWith(goal: goal);
      await updateProfile(updatedProfile);
    }
  }

  Future<void> updateProfileIcon(String iconName) async {
    if (state.hasValue && state.value!.profile != null) {
      final currentProfile = state.value!.profile!;
      final updatedProfile = currentProfile.copyWith(
        profileIconName: iconName,
      );
      await updateProfile(updatedProfile);
    }
  }
}
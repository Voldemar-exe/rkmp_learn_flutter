import 'package:rkmp_learn_flutter/features/profile/data/models/profile.dart';

class ProfileState {
  final bool isLoading;
  final bool isError;
  final Profile? profile;

  const ProfileState({
    this.isLoading = false,
    this.isError = false,
    this.profile,
  });

  ProfileState copyWith({
    bool? isLoading,
    bool? isError,
    Profile? profile,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      profile: profile ?? this.profile,
    );
  }
}
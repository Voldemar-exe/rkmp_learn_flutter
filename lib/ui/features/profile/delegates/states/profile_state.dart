import '../../../../../core/models/profile.dart';

class ProfileState {
  final Profile? profile;
  final bool isLoading;
  final bool isError;

  const ProfileState({
    this.profile,
    this.isLoading = false,
    this.isError = false,
  });

  ProfileState copyWith({
    Profile? profile,
    bool? isLoading,
    bool? isError,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
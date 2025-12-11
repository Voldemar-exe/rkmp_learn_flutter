import '../../../../core/models/profile.dart';

class PrefsProfileDto {
  final String username;
  final String? icon_name;

  PrefsProfileDto({required this.username, this.icon_name});

  factory PrefsProfileDto.fromModel(Profile model) {
    return PrefsProfileDto(
      username: model.username,
      icon_name: model.profileIconName,
    );
  }

  Profile toModel() {
    return Profile(
      username: username,
      profileIconName: icon_name ?? 'person'
    );
  }
}

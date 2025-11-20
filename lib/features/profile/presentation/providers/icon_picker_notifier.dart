import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rkmp_learn_flutter/core/constants/profile_constants.dart';

part 'icon_picker_notifier.g.dart';

@riverpod
class IconPickerNotifier extends _$IconPickerNotifier {
  @override
  String build() {
    return ProfileIconConstants.profileIcons.entries.first.key;
  }

  void updateIcon(String newIconName) {
    state = newIconName;
  }
}
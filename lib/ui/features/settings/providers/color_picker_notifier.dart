import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rkmp_learn_flutter/ui/shared/theme/app_colors.dart';

part 'color_picker_notifier.g.dart';

@riverpod
class ColorPickerNotifier extends _$ColorPickerNotifier {
  @override
  Color build() {
    return AppColors.primaryColors.first;
  }

  void updateColor(Color color) {
    state = color;
  }
}

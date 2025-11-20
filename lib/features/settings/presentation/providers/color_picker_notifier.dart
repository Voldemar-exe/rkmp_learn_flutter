import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rkmp_learn_flutter/core/constants/colors_constants.dart';

part 'color_picker_notifier.g.dart';

@riverpod
class ColorPickerNotifier extends _$ColorPickerNotifier {
  @override
  Color build() {
    return ColorsConstants.primaryColors.first;
  }

  void updateColor(Color color) {
    state = color;
  }
}

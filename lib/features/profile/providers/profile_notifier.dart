import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rkmp_learn_flutter/features/tasks/providers/tasks_notifier.dart';
import 'package:rkmp_learn_flutter/features/tasks/providers/templates_notifier.dart';

import '../../../core/models/user.dart';

part 'generated_code/profile_notifier.g.dart';

@Riverpod(keepAlive: true)
class ProfileNotifier extends _$ProfileNotifier {
  late final TextEditingController goalController;

  @override
  User build() {
    goalController = TextEditingController();
    ref.onDispose(() {
      goalController.dispose();
    });
    return User(username: 'guest', goal: 5);
  }

  void updateGoal(int newGoal) {
    if (newGoal > 0) {
      state = state.copyWith(goal: newGoal);
    }
  }

  void resetToDefaults() {
    ref.read(tasksProvider.notifier).resetToDefaults();
    ref.read(templatesProvider.notifier).resetToDefaults();
    state = User(username: 'guest', goal: 5);
  }
}
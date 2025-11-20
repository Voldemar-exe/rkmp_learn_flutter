import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rkmp_learn_flutter/core/constants/profile_constants.dart';
import 'package:rkmp_learn_flutter/features/profile/presentation/screens/goal_input_dialog.dart';
import 'package:rkmp_learn_flutter/features/profile/presentation/screens/icon_picker_dialog.dart';
import 'package:rkmp_learn_flutter/features/profile/presentation/store/profile_view_model.dart';
import 'package:rkmp_learn_flutter/features/tasks/providers/tasks_notifier.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void _showGoalInputDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    final currentState = ref.watch(profileViewModelProvider);

    if (currentState.hasValue && currentState.value!.profile != null) {
      controller.text = currentState.value!.profile!.goal.toString();
    }

    showDialog(
      context: context,
      builder: (context) {
        return GoalInputDialog(controller: controller);
      },
    );
  }

  void _showIconPickerDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return IconPickerDialog(
          onIconSelected: (iconName) {
            ref
                .read(profileViewModelProvider.notifier)
                .updateProfileIcon(iconName);
          },
        );
      },
    );
  }

  String getRemainingText(int remainingCount) {
    if (remainingCount > 0) {
      return 'Остально: $remainingCount';
    } else {
      return 'Цель выполнена!';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileViewModelProvider);
    final completedCount = ref.watch(tasksProvider.notifier).completedCount;

    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: profileState.when(
        data: (state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.isError) {
            return const Center(child: Text('Ошибка загрузки профиля'));
          }

          final profile = state.profile;
          if (profile == null) {
            return const Center(child: Text('Нет доступного профиля'));
          }

          final remaining = profile.goal - completedCount;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _showIconPickerDialog(context, ref),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                        width: 2,
                      ),
                    ),
                    child: profile.profileIconName != null
                        ? Icon(
                            ProfileIconConstants.profileIcons[profile
                                .profileIconName],
                            size: 40,
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                          )
                        : const Icon(Icons.person, size: 40),
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  'Имя: ${profile.username}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'Цель: ${profile.goal}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  getRemainingText(remaining),
                  style: TextStyle(
                    fontSize: 20,
                    color: remaining > 0 ? Colors.orange : Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () =>
                      Router.neglect(context, () => context.go('/tasks-list')),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 60),
                  ),
                  child: const Text(
                    'Список задач',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => _showGoalInputDialog(context, ref),
                  icon: const Icon(Icons.edit),
                  label: const Text('Изменить цель'),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => _showIconPickerDialog(context, ref),
                  icon: const Icon(Icons.face),
                  label: const Text('Поменять иконку'),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

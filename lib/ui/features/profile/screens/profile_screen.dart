import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rkmp_learn_flutter/ui/features/profile/screens/profile_icon_picker_dialog.dart';
import '../../../shared/constants/profile_constants.dart';
import '../../../shared/providers/delete_profile_notifier.dart';
import '../../auth/delegates/auth_view_model.dart';
import '../delegates/profile_view_model.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void _showProfileIconPickerDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return ProfileIconPickerDialog(
          onIconSelected: (iconName) {
            ref
                .read(profileViewModelProvider.notifier)
                .updateProfileIcon(iconName);
          },
        );
      },
    );
  }

  void _showChangeUsernameDialog(
    BuildContext context,
    WidgetRef ref,
    String currentUsername,
  ) {
    final controller = TextEditingController(text: currentUsername);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Изменить никнейм'),
          content: TextField(
            controller: controller,
            maxLength: 20,
            decoration: const InputDecoration(
              hintText: 'Введите новый никнейм',
            ),
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                final newUsername = controller.text.trim();
                if (newUsername.isNotEmpty && newUsername != currentUsername) {
                  ref
                      .read(profileViewModelProvider.notifier)
                      .updateUsername(newUsername);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteAccount(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Удалить профиль?'),
          content: const Text(
            'Это действие нельзя отменить. Все данные будут удалены.',
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                try {
                  await ref.read(deleteProfileProvider.future);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    Router.neglect(context, () => context.go('/login'));
                  }
                } catch (error) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Ошибка: $error')),
                    );
                  }
                }
              },
              child: const Text(
                'Удалить',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileViewModelProvider);

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

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _showProfileIconPickerDialog(context, ref),
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
                      child: Icon(
                              ProfileIconConstants.profileIcons[profile
                                  .profileIconName],
                              size: 40,
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                            ),
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
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => _showProfileIconPickerDialog(context, ref),
                    icon: const Icon(Icons.face),
                    label: const Text('Поменять иконку'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => _showChangeUsernameDialog(
                      context,
                      ref,
                      profile.username,
                    ),
                    icon: const Icon(Icons.edit),
                    label: const Text('Изменить никнейм'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () => _confirmDeleteAccount(context, ref),
                    icon: const Icon(Icons.delete, color: Colors.white),
                    label: const Text(
                      'Удалить профиль',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      ref.read(authViewModelProvider.notifier).logout();
                      Router.neglect(context, () => context.go('/login'));
                    },
                    icon: const Icon(Icons.exit_to_app),
                    label: const Text('Выйти'),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

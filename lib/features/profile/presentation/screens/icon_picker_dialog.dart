import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rkmp_learn_flutter/core/constants/profile_constants.dart';
import 'package:rkmp_learn_flutter/features/profile/presentation/providers/icon_picker_notifier.dart';

class IconPickerDialog extends ConsumerWidget {
  final Function(String) onIconSelected;

  const IconPickerDialog({super.key, required this.onIconSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIconName = ref.watch(iconPickerProvider);

    return AlertDialog(
      title: const Text('Выберите иконку профиля'),
      content: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: ProfileIconConstants.profileIcons.length,
          itemBuilder: (context, index) {
            final icon = ProfileIconConstants.profileIcons.entries
                .toList()[index];

            return GestureDetector(
              onTap: () {
                ref.read(iconPickerProvider.notifier).updateIcon(icon.key);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: currentIconName == icon.key
                      ? Colors.blue.withValues(alpha: 0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: currentIconName == icon.key
                        ? Colors.blue.withValues(alpha: 0.8)
                        : Colors.grey,
                    width: 2,
                  ),
                ),
                width: 50,
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon.value,
                      size: 32,
                      color: currentIconName == icon.key
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getIconDisplayName(icon.key),
                      style: TextStyle(
                        fontSize: 10,
                        color: currentIconName == icon.key
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            onIconSelected(currentIconName);
            Navigator.pop(context);
          },
          child: const Text('Сохранить'),
        ),
      ],
    );
  }

  String _getIconDisplayName(String iconName) {
    return iconName
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(0)}')
        .trim()
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}

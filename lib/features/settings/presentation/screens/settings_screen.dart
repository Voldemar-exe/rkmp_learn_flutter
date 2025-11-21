import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rkmp_learn_flutter/features/settings/presentation/providers/color_picker_notifier.dart';
import 'package:rkmp_learn_flutter/features/settings/presentation/store/settings_view_model.dart';
import 'package:rkmp_learn_flutter/features/settings/presentation/screens/color_picker_dialog.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: settingsState.when(
        data: (state) {
          final settings = state.settings;
          if (settings == null) {
            return const Center(child: Text('Настройки недоступны'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ListTile(
                  title: const Text('Тема'),
                  subtitle: Text(_getThemeModeText(settings.themeMode)),
                  trailing: DropdownButton<ThemeMode>(
                    value: settings.themeMode,
                    items: ThemeMode.values.map((mode) {
                      return DropdownMenuItem(
                        value: mode,
                        child: Text(_getThemeModeText(mode)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        ref
                            .read(settingsViewModelProvider.notifier)
                            .updateThemeMode(value);
                      }
                    },
                  ),
                ),

                ListTile(
                  title: const Text('Основной цвет'),
                  subtitle: Text('Текущий цвет'),
                  trailing: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: settings.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _showColorPicker(context, ref, settings.primaryColor);
                        },
                        child: const Text('Выбрать цвет'),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  String _getThemeModeText(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Светлая';
      case ThemeMode.dark:
        return 'Темная';
      case ThemeMode.system:
        return 'Системная';
    }
  }

  void _showColorPicker(
    BuildContext context,
    WidgetRef ref,
    Color currentColor,
  ) {
    ref.read(colorPickerProvider.notifier).updateColor(currentColor);
    showDialog(
      context: context,
      builder: (context) => ColorPickerDialog(
        onColorSelected: (color) {
          ref.read(settingsViewModelProvider.notifier).updatePrimaryColor(color);
        },
      ),
    );
  }
}

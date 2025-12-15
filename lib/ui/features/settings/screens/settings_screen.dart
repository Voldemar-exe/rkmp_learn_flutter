import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rkmp_learn_flutter/ui/shared/mappers/app_settings_mapper.dart';

import '../delegates/settings_view_model.dart';
import '../providers/color_picker_notifier.dart';
import 'color_picker_dialog.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsViewModelProvider);

    final isTablet = MediaQuery.of(context).size.shortestSide > 600;

    final padding = EdgeInsets.all(isTablet ? 24.0 : 16.0);
    final iconSize = isTablet ? 40.0 : 32.0;

    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: settingsState.when(
        data: (state) {
          final settings = state.settings;
          if (settings == null) {
            return const Center(child: Text('Настройки недоступны'));
          }

          return Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  dense: !isTablet,
                  visualDensity: isTablet
                      ? VisualDensity.comfortable
                      : VisualDensity.standard,
                  title: const Text('Тема'),
                  subtitle: Text(_getThemeModeText(settings.themeModeAsEnum)),
                  trailing: DropdownButton<ThemeMode>(
                    value: settings.themeModeAsEnum,
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
                  dense: !isTablet,
                  visualDensity: isTablet
                      ? VisualDensity.comfortable
                      : VisualDensity.standard,
                  title: const Text('Основной цвет'),
                  subtitle: const Text('Текущий цвет'),
                  trailing: IconButton(
                    iconSize: iconSize,
                    icon: const Icon(Icons.circle),
                    color: settings.primaryColorAsColor,
                    onPressed: () {
                      _showColorPicker(
                        context,
                        ref,
                        settings.primaryColorAsColor,
                      );
                    },
                  ),
                ),
                SizedBox(height: isTablet ? 24.0 : 16.0),
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
          ref
              .read(settingsViewModelProvider.notifier)
              .updatePrimaryColor(color);
        },
      ),
    );
  }
}

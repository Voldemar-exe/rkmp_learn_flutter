import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rkmp_learn_flutter/core/constants/colors_constants.dart';
import 'package:rkmp_learn_flutter/features/settings/presentation/providers/color_picker_notifier.dart';

class ColorPickerDialog extends ConsumerWidget {
  final Function(Color) onColorSelected;

  const ColorPickerDialog({
    super.key,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = ref.watch(colorPickerProvider);
    final colorPicker = ref.watch(colorPickerProvider.notifier);

    return AlertDialog(
      title: const Text('Выберите цвет'),
      content: SizedBox(
        width: double.maxFinite,
        child: Wrap(
          spacing: 8,
          children: [
            for (final color in ColorsConstants.primaryColors)
              GestureDetector(
                onTap: () {
                  colorPicker.updateColor(color);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selectedColor == color
                          ? Colors.black
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            onColorSelected(selectedColor);
            Navigator.pop(context);
          },
          child: const Text('Выбрать'),
        ),
      ],
    );
  }
}

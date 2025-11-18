import 'dart:math';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/task_template.dart';

part 'generated_code/templates_notifier.g.dart';

@Riverpod(keepAlive: true)
class TemplatesNotifier extends _$TemplatesNotifier {
  static final List<TaskTemplate> _defaultTemplates = [
    TaskTemplate(text: 'Купить продукты', tags: ['личное', 'дом']),
    TaskTemplate(text: 'Прочитать книгу', tags: ['учеба', 'развитие']),
    TaskTemplate(text: 'Сходить в спортзал', tags: ['здоровье', 'спорт']),
    TaskTemplate(text: 'Позвонить другу', tags: ['социальное']),
    TaskTemplate(text: 'Убраться в комнате', tags: ['личное', 'дом']),
  ];

  @override
  List<TaskTemplate> build() {
    return _defaultTemplates;
  }

  void addTemplate(TaskTemplate template) {
    state = [...state, template];
  }

  void updateTemplate(int index, TaskTemplate updated) {
    if (index < 0 || index >= state.length) return;
    final newState = List<TaskTemplate>.from(state);
    newState[index] = updated;
    state = newState;
  }

  void removeTemplate(int index) {
    if (index < 0 || index >= state.length) return;
    final newState = List<TaskTemplate>.from(state);
    newState.removeAt(index);
    state = newState;
  }

  void resetToDefaults() {
    state = _defaultTemplates;
  }

  TaskTemplate? getRandomTemplate() {
    if (state.isEmpty) return null;
    return state[Random().nextInt(state.length)];
  }
}
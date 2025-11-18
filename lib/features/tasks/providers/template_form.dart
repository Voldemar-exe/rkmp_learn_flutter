import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/task_template.dart';

part 'generated_code/template_form.g.dart';

@riverpod
class TemplateForm extends _$TemplateForm {
  late final TextEditingController templateController;
  late final TextEditingController tagController;

  @override
  TemplateFormData build() {
    templateController = TextEditingController();
    tagController = TextEditingController();
    ref.onDispose(() {
      templateController.dispose();
      tagController.dispose();
    });
    return TemplateFormData();
  }

  void setTags(List<String> tags) {
    state = state.copyWith(tags: tags);
  }

  void addTag() {
    if (tagController.text.trim().isEmpty ||
        state.tags.contains(tagController.text.trim())) {
      return;
    }
    state = state.copyWith(tags: [...state.tags, tagController.text.trim()]);
    tagController.text = '';
  }

  void removeTag(String tag) {
    state = state.copyWith(tags: state.tags.where((t) => t != tag).toList());
  }

  void reset() {
    state = TemplateFormData();
    templateController.text = '';
    tagController.text = '';
  }

  TaskTemplate? buildTemplate() {
    if (templateController.text.trim().isEmpty) return null;
    return TaskTemplate(text: templateController.text.trim(), tags: state.tags);
  }

  void loadTemplate(TaskTemplate template) {
    templateController.text = template.text;
    state = state.copyWith(tags: template.tags);
  }

  bool get isValid => templateController.text.trim().isNotEmpty;
}

class TemplateFormData {
  final List<String> tags;

  const TemplateFormData({this.tags = const []});

  TemplateFormData copyWith({List<String>? tags}) {
    return TemplateFormData(tags: tags ?? this.tags);
  }
}

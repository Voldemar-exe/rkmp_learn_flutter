import 'package:flutter/widgets.dart';
import '../core/models/app_data.dart';

class AppManagerInherited extends InheritedWidget {
  final AppData data;

  const AppManagerInherited({
    super.key,
    required this.data,
    required super.child,
  });

  static AppManagerInherited of(BuildContext context) {
    final AppManagerInherited? result = context
        .dependOnInheritedWidgetOfExactType<AppManagerInherited>();
    assert(result != null, 'AppManagerInherited not found in widget tree');
    return result!;
  }

  @override
  bool updateShouldNotify(AppManagerInherited oldWidget) {
    return oldWidget.data != data;
  }

  int get completedCount => data.tasks.where((t) => t.isCompleted).length;

  int get remaining => (data.goal - completedCount).clamp(0, data.goal);
}

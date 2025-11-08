import 'package:flutter/widgets.dart';
import 'package:rkmp_learn_flutter/app/app_repository.dart';

class AppManagerInherited extends InheritedWidget {
  final AppRepository appRepository;

  const AppManagerInherited({
    super.key,
    required this.appRepository,
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
    return appRepository.data != oldWidget.appRepository.data;
  }
}

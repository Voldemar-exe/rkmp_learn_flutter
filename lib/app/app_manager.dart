import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../core/models/app_data.dart';
import 'app_manager_inherited.dart';
import 'app_data_service.dart';

class AppManager extends StatefulWidget {
  final Widget child;
  final AppData initialData;

  const AppManager({super.key, required this.child, required this.initialData});

  @override
  State<AppManager> createState() => _AppManagerState();
}

class _AppManagerState extends State<AppManager> {
  late AppData _data;

  @override
  void initState() {
    super.initState();
    _data = widget.initialData;

    GetIt.instance.registerSingleton<AppDataService>(
      AppDataServiceImpl((updateFn) {
        setState(() {
          _data = updateFn(_data);
        });
      }),
      signalsReady: true,
    );
  }

  @override
  void dispose() {
    GetIt.instance.unregister<AppDataService>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppManagerInherited(data: _data, child: widget.child);
  }
}

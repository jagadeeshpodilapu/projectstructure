import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_struct/presentation/routes.dart';
import 'package:project_struct/presentation/theme/theme_manager.dart';

import '../providers/state_notifiers/state_notifiers.dart';

class AppName extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtil.init(context);
    final themeNotifier = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      title: 'AppName',
      debugShowCheckedModeBanner: false,
      themeMode: themeNotifier.themeMode,
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      routeInformationParser: Routes.router.routeInformationParser,
      routerDelegate: Routes.router.routerDelegate,
      routeInformationProvider: Routes.router.routeInformationProvider,
    );
  }
}

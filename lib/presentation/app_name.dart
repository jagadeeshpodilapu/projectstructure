import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_struct/common/app_enums.dart';
import 'package:project_struct/di/get_it.dart';
import 'package:project_struct/presentation/providers/data_provider.dart';
import 'package:project_struct/presentation/routes.dart';
import 'package:project_struct/presentation/theme/app_colors.dart';
import 'package:project_struct/presentation/theme/theme_manager.dart';
import 'package:provider/provider.dart';

import '../common/constants/languages.dart';
import '../common/constants/route_constants.dart';
import 'app_localizations.dart';
import 'fade_page_route_builder.dart';

class AppName extends StatefulWidget {
  @override
  _AppNameState createState() => _AppNameState();
}

class _AppNameState extends State<AppName> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final ThemeData theme = ThemeData.light();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) =>DataProvider() ),)
      ],
      child: MaterialApp(
        title: 'AppName',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: AppThemeData.lightThemeData,
        darkTheme: AppThemeData.darkThemeData,
        locale: const Locale('en', 'US'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        initialRoute: RouteList.initial,
        onGenerateRoute: (RouteSettings settings) {
          final routes = Routes.getRoutes(settings);
          final WidgetBuilder? builder = routes[settings.name];
          return FadePageRouteBuilder(
            builder: builder!,
            settings: settings,
          );
        },
      ),
    );
 }
}

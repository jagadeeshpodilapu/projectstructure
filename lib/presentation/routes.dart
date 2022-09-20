import 'package:flutter/material.dart';
import 'package:project_struct/presentation/views/homepage/home_page.dart';
import 'package:project_struct/presentation/views/homepage/list_view_data.dart';

import '../common/constants/route_constants.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
         RouteList.initial: (context) =>  HomeScreen(),
        // RouteList.home: (context) => HomeScreen(),
        // RouteList.movieDetail: (context) => MovieDetailScreen(
        //       movieDetailArguments: setting.arguments as MovieDetailArguments,
        //     ),
        // RouteList.watchTrailer: (context) => WatchVideoScreen(
        //       watchVideoArguments: setting.arguments as WatchVideoArguments,
        //     ),
        // RouteList.favorite: (context) => FavoriteScreen(),
      };
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'views/movies/movies.dart';

class Routes {
 static GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const MovieList(),
      ),
      GoRoute(
        path: '/:id',
        builder: (context, state) {
          // use state.params to get router parameter values
          //final family = Families.family(state.params['fid']!);
          final id = state.params['id'];

          return MovieDetails(id: id.toString());
        },
      ),
    ],
  );
}
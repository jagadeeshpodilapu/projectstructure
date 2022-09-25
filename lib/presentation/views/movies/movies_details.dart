import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/movie_model.dart';
import '../../../providers/state_notifiers/movie_state_notifier.dart';
import '../../../providers/state_notifiers/state_notifiers.dart';

class MovieDetails extends ConsumerWidget {
  MovieDetails({Key? key, required String this.id}) : super(key: key);

  final String id;
  ThemeMode themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Future<Movie> movie =
        ref.watch(moviesProvider.notifier).loadMovie(id);
    final themeNotifier = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Sample"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () {
              themeNotifier.isDark = !themeNotifier.isDark;
              themeNotifier.toggleTheme(themeNotifier.isDark);
            },
          )
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          child: FutureBuilder<Movie>(
            future: movie, // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot<Movie> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                final Movie mov = snapshot.data as Movie;

                children = <Widget>[
                  Image.network(mov.poster.toString()),
                  const SizedBox(height: 20),
                  Text("${mov.title} (${mov.year})",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.all(30),
                      child: Text(mov.plot.toString())),
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ];
              } else {
                children = const <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  )
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
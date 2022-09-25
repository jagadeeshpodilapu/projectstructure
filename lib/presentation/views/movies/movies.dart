import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../models/movie_model.dart';
import '../../../providers/state_notifiers/movie_state_notifier.dart';
import 'movie_card.dart';

class MovieList extends ConsumerWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Movie> formattedMovies = ref.watch(moviesProvider).movies ?? [];
    bool isLoading = ref.watch(moviesProvider).isLoading ?? false;

    return Scaffold(
    
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a search term',
                ),
                onChanged: (text) async {
                  // text here is the inputed text
                  await ref.read(moviesProvider.notifier).filterMovies(text);
                },
              ),
            ),
            isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: formattedMovies.length,
                            itemBuilder: (BuildContext context, int index) {
                              Movie movie = formattedMovies[index];

                              return MovieCard(movie: movie);
                            })),
                  )
          ],
        ),
      ),
    );
  }
}

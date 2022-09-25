// Creating state notifier provider
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/movie_model.dart';
import '../../service/movie_service.dart';

class MovieState {
  List<Movie>? movies;
  bool? isLoading = true;

  MovieState({this.movies, this.isLoading});

    MovieState copyWith({List<Movie>? movies,bool? isLoading}) => MovieState(
        movies: movies ?? this.movies,
        isLoading: isLoading ?? this.isLoading,
        
      );


}

final moviesProvider =
    StateNotifierProvider<MovieNotifier, MovieState>((ref) => MovieNotifier());

// Creating Notifier
class MovieNotifier extends StateNotifier<MovieState> {
  // Notifier constructor - call functions on provider initialization
  MovieNotifier() : super(MovieState()) {
    loadMovies();
  }

  // Simple loadMovies functions that will load json file from data folder
  loadMovies() async {
    state = state.copyWith(isLoading: true);
    final moviesList = await MovieService().fetchMovies();
    // Convert list to list of movies using the movie class constructor
    final movies = moviesList.map((e) => Movie.fromJson(e)).toList();
    // Update state in provider
    state = state.copyWith(movies: movies, isLoading: false);
  }

  Future<Movie> loadMovie(id) async {
    final movieData = await MovieService().fetchMovie(id);
    // Convert list to list of movies using the movie class constructor
    final movie = Movie.fromJson(movieData);
    // Update state in provider
    return movie;
  }

  filterMovies(filter) async {
    state = state.copyWith(isLoading: true);
    final moviesList = await MovieService().fetchMovies(filter);
    // Convert list to list of movies using the movie class constructor with simple filter title function inside
    final movies = moviesList.map((e) => Movie.fromJson(e)).toList();

    state = state.copyWith(movies: movies, isLoading: false);
  }

  // updateMovie(id, movieData) async {
  //   //state = state.copyWith(isLoading: true);
  //   final movieJson = await MovieService().updateMovie(id, movieData);
  //   // Convert list to list of movies using the movie class constructor
  //   final movie = Movie.fromJson(movieJson);

  //   final index = state.movies?.indexWhere((element) => element.id == movie.id);
  //   final movies = List<Movie>.from(state.movies!);
  //   movies[index??0] = movie;
  //   // Update state in provider
  //   state = state.copyWith(movies: movies, isLoading: false);
  // }

  deleteMovie(id) async {
    //state = state.copyWith(isLoading: true);
    final movieJson = await MovieService().deleteMovie(id);
    // Convert list to list of movies using the movie class constructor

    final index = state.movies?.indexWhere((element) => element.id == id);
    final movies = List<Movie>.from(state.movies!);
    movies.removeAt(index??0);
    // Update state in provider
    state = state.copyWith(movies: movies, isLoading: false);
  }
}

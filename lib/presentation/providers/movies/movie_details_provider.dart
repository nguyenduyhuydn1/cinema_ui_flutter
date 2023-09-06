import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinema_ui_flutter/domain/entities/movie.dart';

import 'package:cinema_ui_flutter/presentation/providers/movies_repository_provider.dart';

final movieDetailProvider =
    StateNotifierProvider<MovieDetailNotifier, Map<String, Movie>>((ref) {
  final fetchById = ref.watch(moviesRepositoryImpl).getMovieById;
  return MovieDetailNotifier(fetchById: fetchById);
});

/*
  {
    '505642': Movie(),
  }
*/

class MovieDetailNotifier extends StateNotifier<Map<String, Movie>> {
  final Future<Movie> Function(String id) fetchById;
  MovieDetailNotifier({required this.fetchById}) : super({});

  Future<void> getMovieById(movieId) async {
    if (state[movieId] != null) return;
    final movie = await fetchById(movieId);
    state = {...state, movieId: movie};
  }
}

// class MovieDetailState {
//   final Map<String, Movie> movies;

//   MovieDetailState({this.movies = const {}});

//   MovieDetailState copyWith({Map<String, Movie>? movies}) => MovieDetailState(
//         movies: movies ?? this.movies,
//       );
// }

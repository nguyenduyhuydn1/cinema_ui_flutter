import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinema_ui_flutter/domain/entities/movie.dart';

import 'package:cinema_ui_flutter/presentation/providers/movies_repository_provider.dart';

final tvDetailsProvider =
    StateNotifierProvider<TvDetailNotifier, Map<String, Movie>>((ref) {
  final fetchById = ref.watch(moviesRepositoryImpl).getTvById;
  return TvDetailNotifier(fetchById: fetchById);
});

/*
  {
    '505642': Movie(),
  }
*/

class TvDetailNotifier extends StateNotifier<Map<String, Movie>> {
  final Future<Movie> Function(String id) fetchById;
  TvDetailNotifier({required this.fetchById}) : super({});

  Future<void> getTvById(String movieId) async {
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

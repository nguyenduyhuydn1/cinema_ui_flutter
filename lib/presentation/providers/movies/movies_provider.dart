import 'package:cinema_ui_flutter/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinema_ui_flutter/presentation/providers/movies_repository_provider.dart';

final nowPlayingProvider =
    StateNotifierProvider<MoviesNotifier, MoviesState>((ref) {
  final fetch = ref.watch(moviesRepositoryImpl).getNowPlaying;
  return MoviesNotifier(fetch: fetch);
});

final popularProvider =
    StateNotifierProvider<MoviesNotifier, MoviesState>((ref) {
  final fetch = ref.watch(moviesRepositoryImpl).getPopular;
  return MoviesNotifier(fetch: fetch);
});
final topRatedProvider =
    StateNotifierProvider<MoviesNotifier, MoviesState>((ref) {
  final fetch = ref.watch(moviesRepositoryImpl).getTopRated;
  return MoviesNotifier(fetch: fetch);
});

final upComingProvider =
    StateNotifierProvider<MoviesNotifier, MoviesState>((ref) {
  final fetch = ref.watch(moviesRepositoryImpl).getUpcoming;
  return MoviesNotifier(fetch: fetch);
});

class MoviesNotifier extends StateNotifier<MoviesState> {
  final Future<List<Movie>> Function({int page}) fetch;

  bool isLoading = false;

  MoviesNotifier({required this.fetch}) : super(MoviesState()) {
    loadNextPage();
  }

  Future loadNextPage({page = 1}) async {
    if (state.isLoading || state.isLastPage) return;
    state = state.copyWith(isLoading: true);

    final movies = await fetch(page: state.page);

    if (movies.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
      return;
    }

    state = state.copyWith(
      isLastPage: false,
      isLoading: false,
      page: state.page + 1,
      movies: [...state.movies, ...movies],
    );
  }
}

class MoviesState {
  final bool isLastPage;
  final int page;
  final bool isLoading;
  final List<Movie> movies;

  MoviesState({
    this.isLastPage = false,
    this.page = 1,
    this.isLoading = false,
    this.movies = const [],
  });

  MoviesState copyWith({
    bool? isLastPage,
    int? page,
    bool? isLoading,
    List<Movie>? movies,
  }) =>
      MoviesState(
        isLastPage: isLastPage ?? this.isLastPage,
        page: page ?? this.page,
        isLoading: isLoading ?? this.isLoading,
        movies: movies ?? this.movies,
      );
}

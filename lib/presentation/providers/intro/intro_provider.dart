import 'package:cinema_ui_flutter/domain/entities/movie.dart';
import 'package:cinema_ui_flutter/presentation/providers/intro/intro_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final introProvider1 =
    StateNotifierProvider.autoDispose<IntroNotifier, IntroState>((ref) {
  final fetchMovie = ref.watch(introRepositoryImpl).getNowPlaying;
  return IntroNotifier(fetchMovie: fetchMovie);
});
final introProvider2 =
    StateNotifierProvider.autoDispose<IntroNotifier, IntroState>((ref) {
  final fetchMovie = ref.watch(introRepositoryImpl).getNowPlaying;
  return IntroNotifier(fetchMovie: fetchMovie);
});
final introProvider3 =
    StateNotifierProvider.autoDispose<IntroNotifier, IntroState>((ref) {
  final fetchMovie = ref.watch(introRepositoryImpl).getNowPlaying;
  return IntroNotifier(fetchMovie: fetchMovie);
});

class IntroNotifier extends StateNotifier<IntroState> {
  final Future<List<Movie>> Function({int page}) fetchMovie;
  IntroNotifier({required this.fetchMovie}) : super(IntroState());

  Future loadIntro({page = 1}) async {
    final List<Movie> movies = await fetchMovie(page: page);
    state = state.copyWith(movies: movies);
  }
}

class IntroState {
  final bool isLastPage;
  final int page;
  final bool isLoading;
  final List<Movie> movies;

  IntroState({
    this.isLastPage = false,
    this.page = 5,
    this.isLoading = false,
    this.movies = const [],
  });

  IntroState copyWith({
    bool? isLastPage,
    int? page,
    bool? isLoading,
    List<Movie>? movies,
  }) =>
      IntroState(
        isLastPage: isLastPage ?? this.isLastPage,
        page: page ?? this.page,
        isLoading: isLoading ?? this.isLoading,
        movies: movies ?? this.movies,
      );
}

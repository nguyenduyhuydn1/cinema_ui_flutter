import 'package:cinema_ui_flutter/domain/entities/movie.dart';
import 'package:cinema_ui_flutter/presentation/providers/movies/movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final slideShowProvider = Provider.autoDispose<List<Movie>>((ref) {
  final movies = ref.watch(nowPlayingProvider).movies;
  if (movies.isEmpty) return [];

  return movies.sublist(0, 7);
});

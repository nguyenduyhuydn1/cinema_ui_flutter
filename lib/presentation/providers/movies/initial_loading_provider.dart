import 'package:cinema_ui_flutter/presentation/providers/movies/movies_provider.dart';
import 'package:cinema_ui_flutter/presentation/providers/movies/slide_show_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingMoviesProvider = Provider.autoDispose<bool>((ref) {
  final data0 = ref.watch(slideShowProvider).isEmpty;
  final data1 = ref.watch(nowPlayingProvider).movies.isEmpty;
  final data2 = ref.watch(popularProvider).movies.isEmpty;
  final data3 = ref.watch(topRatedProvider).movies.isEmpty;
  final data4 = ref.watch(upComingProvider).movies.isEmpty;

  if (data0 || data1 || data2 || data3 || data4) return true;
  return false;
});

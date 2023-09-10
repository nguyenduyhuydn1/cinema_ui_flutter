import 'dart:convert';

import 'package:cinema_ui_flutter/domain/entities/movie.dart';
import 'package:cinema_ui_flutter/infrastructure/mappers/movie_mapper.dart';
import 'package:cinema_ui_flutter/shared/services/shared_preferences/key_value_storage_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Movie>>((ref) {
  final keyValueStorageService = KeyValueStorageServiceImpl();
  return FavoritesNotifier(keyValueStorageService: keyValueStorageService);
});

class FavoritesNotifier extends StateNotifier<List<Movie>> {
  final KeyValueStorageServiceImpl keyValueStorageService;

  FavoritesNotifier({required this.keyValueStorageService}) : super([]);

  Future<void> _entitiesToString(List<Movie> movies) async {
    if (movies.isEmpty) {
      keyValueStorageService.removeKey('favorites');
      return;
    }

    final entityToJson = movies.map((e) => e.toJson()).toList();
    final String encode = jsonEncode(entityToJson);

    await keyValueStorageService.setKeyValue('favorites', encode);
  }

  Future<void> loadNextPage() async {}

  // Future<List<Movie>> loadNextPage() async {
  //   final movies =
  //       await localStorageRepository.loadMovies(offset: page * 10, limit: 20);

  //   page++;
  //   final tempMoviesMap = <int, Movie>{};
  //   for (final movie in movies) {
  //     tempMoviesMap[movie.id] = movie;
  //   }
  //   state = {...state, ...tempMoviesMap};
  //   return movies;
  // }

  Future<void> toggleFavorite(Movie movie) async {
    final checkExists = state.indexWhere((e) => e.id == movie.id);
    if (checkExists == -1) {
      state = [...state, movie];
    } else {
      state = state.where((e) => e.id != movie.id).toList();
    }
    await _entitiesToString(state);
  }

  Future<void> getDataFavorites() async {
    final bool checkKey =
        await keyValueStorageService.checkKeyExists('favorites');
    if (!checkKey) {
      final String encode = jsonEncode([]);
      await keyValueStorageService.setKeyValue('favorites', encode);
      return;
    }

    final favorites =
        await keyValueStorageService.getValue<String>('favorites');
    final decode = jsonDecode(favorites!);
    final List<Movie> movies = [];
    for (final x in decode) {
      movies.add(MovieMapper.jsonToEntity(x));
    }

    state = movies;
  }

  Future<void> setDataFavorites(Movie movie) async {
    final checkExists = state.indexWhere((e) => e.id == movie.id);
    if (checkExists == -1) return;

    state = [...state, movie];
    await _entitiesToString(state);
  }

  // Future<void> removeDataFavorites(String productId) async {
  //   state = state.where((e) => e.id != productId).toList();

  //   await _entitiesToString(state);
  //   // var list = products.map((e) => e.toJson()).toList();
  //   // var xx = jsonEncode(list);
  //   // List<dynamic> xcz = jsonDecode(xx);
  //   // List<dynamic> ddddddddd =
  //   //     xcz.map((e) => ProductMapper.jsonToEntity(e)).toList();

  //   // print(ddddddddd[0].id);
  // }
}

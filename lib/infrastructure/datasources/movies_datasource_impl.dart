import 'package:cinema_ui_flutter/infrastructure/mappers/movie_mapper.dart';
import 'package:cinema_ui_flutter/infrastructure/models/models.dart';
import 'package:dio/dio.dart';

import 'package:cinema_ui_flutter/config/constants/enviroments.dart';
import 'package:cinema_ui_flutter/domain/datasources/movies_datasource.dart';
import 'package:cinema_ui_flutter/domain/entities/movie.dart';

class MoviesDatasourceImpl extends MoviesDataSource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {'language': 'en-US'},
    headers: {
      "accept": 'application/json',
      'Authorization': 'Bearer ${Environment.theMovieDbAccessToken}',
    },
  ));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieRes = MovieResponsive.fromJson(json);
    final List<Movie> movies =
        movieRes.results.map((e) => MovieMapper.movieDbToEntity(e)).toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final res =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});
    return _jsonToMovies(res.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final res =
        await dio.get('/movie/popular', queryParameters: {'page': page});
    return _jsonToMovies(res.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final res =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});
    return _jsonToMovies(res.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final res =
        await dio.get('/movie/upcoming', queryParameters: {'page': page});
    return _jsonToMovies(res.data);
  }

  @override
  Future<Movie> getMovieById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> searchMovies(String query, {int page = 1}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> getSimilarMovies(int movieId) {
    throw UnimplementedError();
  }
}

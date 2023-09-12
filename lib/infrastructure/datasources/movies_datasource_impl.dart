import 'package:cinema_ui_flutter/domain/entities/video.dart';
import 'package:cinema_ui_flutter/infrastructure/mappers/movie_mapper.dart';
import 'package:cinema_ui_flutter/infrastructure/mappers/video_mapper.dart';
import 'package:cinema_ui_flutter/infrastructure/models/models.dart';
import 'package:cinema_ui_flutter/infrastructure/models/video/video_responsive.dart';
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
  Future<Movie> getMovieById(String id) async {
    final res = await dio.get('/movie/$id');
    if (res.statusCode != 200) throw Exception('Movie with id: $id not found');

    final movieDetails = MovieDetails.fromJson(res.data);
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);
    return movie;
  }

  @override
  Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    if (query.isEmpty) return [];

    final res = await dio.get(
      '/search/movie',
      queryParameters: {'query': query, 'page': page},
    );

    return _jsonToMovies(res.data);
  }

  @override
  Future<List<Video>> getYoutubeVideosById(int movieId) async {
    final res = await dio.get('/movie/$movieId/videos');
    if (res.statusCode != 200) throw Exception('youtube is not found');
    final videoResponsive = VideoResponsive.fromJson(res.data);
    final List<Video> videos = [];

    for (final e in videoResponsive.results) {
      if (e.site == 'YouTube') {
        final video = VideoMapper.videoDbToEntity(e);
        videos.add(video);
      }
    }
    return videos;
  }

  @override
  Future<List<Movie>> getTvSeriesToday({page = 1}) async {
    final res = await dio.get(
      '/tv/airing_today',
      queryParameters: {'page': page},
    );

    return _jsonToMovies(res.data);
  }

  @override
  Future<Movie> getTvById(String id) async {
    final res = await dio.get('/tv/$id');
    if (res.statusCode != 200) throw Exception('Movie with id: $id not found');

    final movieDetails = MovieDetails.fromJson(res.data);
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);
    return movie;
  }
}

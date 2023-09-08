import 'package:cinema_ui_flutter/domain/datasources/movies_datasource.dart';

import 'package:cinema_ui_flutter/domain/entities/movie.dart';
import 'package:cinema_ui_flutter/domain/entities/video.dart';

import 'package:cinema_ui_flutter/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl extends MoviesRepository {
  final MoviesDataSource moviesDataSource;

  MoviesRepositoryImpl(this.moviesDataSource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return moviesDataSource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return moviesDataSource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return moviesDataSource.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return moviesDataSource.getUpcoming(page: page);
  }

  @override
  Future<Movie> getMovieById(String id) {
    return moviesDataSource.getMovieById(id);
  }

  @override
  Future<List<Movie>> searchMovies(String query, {int page = 1}) {
    return moviesDataSource.searchMovies(query, page: page);
  }

  @override
  Future<List<Movie>> getSimilarMovies(int movieId) {
    return moviesDataSource.getSimilarMovies(movieId);
  }

  @override
  Future<List<Video>> getYoutubeVideosById(int movieId) {
    return moviesDataSource.getYoutubeVideosById(movieId);
  }
}

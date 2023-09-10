import 'package:cinema_ui_flutter/domain/entities/movie.dart';

import 'package:cinema_ui_flutter/infrastructure/models/models.dart';

class MovieMapper {
  static Movie movieDbToEntity(MovieDb movieDb) => Movie(
        adult: movieDb.adult,
        backdropPath: movieDb.backdropPath != ''
            ? 'https://image.tmdb.org/t/p/w500${movieDb.backdropPath}'
            : "https://www.reelviews.net/resources/img/default_poster.jpg",
        genreIds: movieDb.genreIds.map((e) => e.toString()).toList(),
        id: movieDb.id,
        originalLanguage: movieDb.originalLanguage,
        originalTitle: movieDb.originalTitle,
        overview: movieDb.overview,
        popularity: movieDb.popularity,
        posterPath: movieDb.posterPath != ''
            ? 'https://image.tmdb.org/t/p/w500${movieDb.posterPath}'
            : "https://www.reelviews.net/resources/img/default_poster.jpg",
        releaseDate: movieDb.releaseDate ?? DateTime.now(),
        title: movieDb.title,
        video: movieDb.video,
        voteAverage: movieDb.voteAverage,
        voteCount: movieDb.voteCount,
      );

  static Movie movieDetailsToEntity(MovieDetails movieDb) => Movie(
        adult: movieDb.adult,
        backdropPath: (movieDb.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movieDb.backdropPath}'
            : "https://www.reelviews.net/resources/img/default_poster.jpg",
        genreIds: movieDb.genres.map((e) => e.name).toList(),
        id: movieDb.id,
        originalLanguage: movieDb.originalLanguage,
        originalTitle: movieDb.originalTitle,
        overview: movieDb.overview,
        popularity: movieDb.popularity,
        posterPath: (movieDb.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movieDb.posterPath}'
            : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
        releaseDate: movieDb.releaseDate,
        title: movieDb.title,
        video: movieDb.video,
        voteAverage: movieDb.voteAverage,
        voteCount: movieDb.voteCount,
      );

  static jsonToEntity(Map<String, dynamic> json) => Movie(
        adult: json["adult"],
        backdropPath: json["backdropPath"],
        genreIds: List<String>.from(json["genreIds"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["originalLanguage"],
        originalTitle: json["originalTitle"],
        overview: json["overview"],
        popularity: json["popularity"],
        posterPath: json["posterPath"],
        releaseDate: DateTime.parse(json["releaseDate"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["voteAverage"],
        voteCount: json["voteCount"],
      );
}

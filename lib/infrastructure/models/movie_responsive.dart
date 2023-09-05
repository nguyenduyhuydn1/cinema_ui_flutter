import 'package:cinema_ui_flutter/infrastructure/models/movie_db.dart';

class MovieResponsive {
  final DateTime dates;
  final int page;
  final List<MovieDb> results;
  final int totalPages;
  final int totalResults;

  MovieResponsive({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponsive.fromJson(Map<String, dynamic> json) =>
      MovieResponsive(
        dates: DateTime.now(),
        page: json["page"],
        results:
            List<MovieDb>.from(json["results"].map((x) => MovieDb.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "dates": DateTime.now(),
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String theMovieDbAccessToken =
      dotenv.env['THEMOVIEDB_ACCESS_TOKEN'] ?? 'No api key';
  static String theMovieDbKey =
      dotenv.env['THEMOVIEDB_API_KEY'] ?? 'No api key';
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinema_ui_flutter/infrastructure/repositories/movies_repository_impl.dart';
import 'package:cinema_ui_flutter/infrastructure/datasources/movies_datasource_impl.dart';

final moviesRepositoryImpl =
    Provider((ref) => MoviesRepositoryImpl(MoviesDatasourceImpl()));

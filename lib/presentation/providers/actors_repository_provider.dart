import 'package:cinema_ui_flutter/infrastructure/datasources/actors_datasource_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinema_ui_flutter/infrastructure/repositories/actors_repository_impl.dart';

final actorsRepositoryImpl =
    Provider((ref) => ActorsRepositoryImpl(ActorsDatasourceImpl()));

import 'package:cinema_ui_flutter/domain/datasources/actors_datasource.dart';
import 'package:cinema_ui_flutter/domain/entities/actor.dart';
import 'package:cinema_ui_flutter/domain/repositories/actors_repository.dart';

class ActorsRepositoryImpl extends ActorsRepository {
  final ActorsDatasource actorsDatasource;

  ActorsRepositoryImpl(this.actorsDatasource);

  @override
  Future<List<Actor>> getActorsByMovieId(String movieId) {
    return actorsDatasource.getActorsByMovieId(movieId);
  }
}

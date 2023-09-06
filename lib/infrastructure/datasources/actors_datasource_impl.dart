import 'package:cinema_ui_flutter/config/constants/enviroments.dart';
import 'package:cinema_ui_flutter/domain/datasources/actors_datasource.dart';
import 'package:cinema_ui_flutter/domain/entities/actor.dart';
import 'package:cinema_ui_flutter/infrastructure/mappers/actors_mapper.dart';
import 'package:cinema_ui_flutter/infrastructure/models/actor/credits_responsive.dart';
import 'package:dio/dio.dart';

class ActorsDatasourceImpl extends ActorsDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {'language': 'en-US'},
    headers: {
      "accept": 'application/json',
      'Authorization': 'Bearer ${Environment.theMovieDbAccessToken}',
    },
  ));

  @override
  Future<List<Actor>> getActorsByMovieId(String movieId) async {
    final res = await dio.get('/movie/$movieId/credits');
    final creditsResponsive = CreditsResponsive.fromJson(res.data);
    List<Actor> actors = creditsResponsive.cast
        .map((e) => ActorsMapper.actorDbToEntity(e))
        .toList();

    return actors;
  }
}

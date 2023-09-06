import 'package:cinema_ui_flutter/domain/entities/actor.dart';
import 'package:cinema_ui_flutter/presentation/providers/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsProvider =
    StateNotifierProvider<ActorsNotifier, Map<String, List<Actor>>>((ref) {
  final fetchActorsByMovieId =
      ref.watch(actorsRepositoryImpl).getActorsByMovieId;
  return ActorsNotifier(fetchActorsByMovieId: fetchActorsByMovieId);
});

class ActorsNotifier extends StateNotifier<Map<String, List<Actor>>> {
  Future<List<Actor>> Function(String movieId) fetchActorsByMovieId;

  ActorsNotifier({required this.fetchActorsByMovieId}) : super({});

  Future<void> getActorsById({required String movieId}) async {
    final actors = await fetchActorsByMovieId(movieId);
    state = {
      ...state,
      movieId: [...actors],
    };
  }
}

import 'package:cinema_ui_flutter/domain/entities/actor.dart';

import 'package:cinema_ui_flutter/infrastructure/models/actor/actor_db.dart';

class ActorsMapper {
  static Actor actorDbToEntity(ActorDb actorDb) => Actor(
        id: actorDb.id,
        name: actorDb.name,
        profilePath: actorDb.profilePath != null
            ? 'https://image.tmdb.org/t/p/w500${actorDb.profilePath}'
            : 'https://st3.depositphotos.com/4111759/13425/v/600/depositphotos_134255710-stock-illustration-avatar-vector-male-profile-gray.jpg',
        character: actorDb.character,
      );
}

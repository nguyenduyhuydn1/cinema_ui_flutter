import 'package:cinema_ui_flutter/infrastructure/models/actor/actor_db.dart';

class CreditsResponsive {
  final int id;
  final List<ActorDb> cast;
  final List<ActorDb> crew;

  CreditsResponsive({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory CreditsResponsive.fromJson(Map<String, dynamic> json) =>
      CreditsResponsive(
        id: json["id"],
        cast: List<ActorDb>.from(json["cast"].map((x) => ActorDb.fromJson(x))),
        crew: List<ActorDb>.from(json["crew"].map((x) => ActorDb.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
      };
}

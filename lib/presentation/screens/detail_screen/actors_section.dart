import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinema_ui_flutter/config/constants/size_config.dart';
import 'package:cinema_ui_flutter/domain/entities/actor.dart';

import 'package:cinema_ui_flutter/presentation/providers/providers.dart';

class ActorsSection extends ConsumerStatefulWidget {
  final String movieId;
  const ActorsSection({super.key, required this.movieId});

  @override
  ActorsState createState() => ActorsState();
}

class ActorsState extends ConsumerState<ActorsSection> {
  @override
  void initState() {
    super.initState();
    ref.read(actorsProvider.notifier).getActorsById(movieId: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final List<Actor>? actors = ref.watch(actorsProvider)[widget.movieId];

    if (actors == null) {
      return const SizedBox(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10),
            child: Text(
              "Actors",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: SizeConfig.screenWidth,
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: actors.length,
              itemBuilder: (context, index) {
                final actor = actors[index];

                return Padding(
                  padding: index == 0
                      ? const EdgeInsets.only(right: 10, left: 10)
                      : const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    width: 100,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            actor.profilePath!,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 150,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          actor.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          actor.character!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

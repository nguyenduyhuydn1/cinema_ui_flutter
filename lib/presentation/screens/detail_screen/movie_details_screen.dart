import 'package:animate_do/animate_do.dart';
import 'package:cinema_ui_flutter/config/constants/size_config.dart';
import 'package:cinema_ui_flutter/domain/entities/movie.dart';
import 'package:cinema_ui_flutter/presentation/providers/movies/movie_details_provider.dart';
import 'package:cinema_ui_flutter/presentation/screens/detail_screen/actors_section.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieDetailsScreen extends ConsumerStatefulWidget {
  final String id;
  const MovieDetailsScreen({super.key, required this.id});

  @override
  MovieDetailsScreenState createState() => MovieDetailsScreenState();
}

class MovieDetailsScreenState extends ConsumerState<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieDetailProvider.notifier).getMovieById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieDetailProvider)[widget.id];
    if (movie == null) {
      return const SizedBox(child: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
            delegate:
                SliverChildBuilderDelegate(childCount: 1, (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TitleMovie(movie: movie),
                  _Genres(movie: movie),
                  ActorsSection(movieId: movie.id.toString()),
                  const _Trailers()
                ],
              );
            }),
          )
        ],
      ),
    );
  }
}

class _Trailers extends StatelessWidget {
  const _Trailers();

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

class _Genres extends StatelessWidget {
  final Movie movie;
  const _Genres({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Wrap(
        // crossAxisAlignment: WrapCrossAlignment.start,
        // alignment: WrapAlignment.start,
        children: [
          ...List.generate(movie.genreIds.length, (index) {
            final genres = movie.genreIds[index % movie.genreIds.length];
            return Container(
              margin: index == movie.genreIds.length - 1
                  ? const EdgeInsets.only(right: 0)
                  : const EdgeInsets.only(right: 10),
              child: Chip(
                label: Text(genres),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}

class _TitleMovie extends StatelessWidget {
  final Movie movie;
  const _TitleMovie({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              movie.posterPath,
              width: SizeConfig.screenWidth * 0.3,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: (SizeConfig.screenWidth * 0.7) - 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    wordSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  movie.overview,
                  maxLines: 8,
                  style: const TextStyle(height: 1.3),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: SizeConfig.screenHeight * 0.7,
      foregroundColor: Colors.white,
      actions: [
        Center(
          child: IconButton(
            onPressed: () async {
              // ref.read(localStorageRepositoryProvider)
              //   .toggleFavorite(movie);
              // await ref
              //     .read(favoriteMoviesProvider.notifier)
              //     .toggleFavorite(movie);

              // ref.invalidate(isFavoriteProvider(movie.id));
            },
            icon: true
                ? const Icon(Icons.favorite_rounded, color: Colors.red)
                : const Icon(Icons.favorite_border),
          ),
        ),
        const SizedBox(width: 10),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(bottom: 0),
        title: _CustomGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.7, 1.0],
            colors: [Colors.transparent, scaffoldBackgroundColor]),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            const _CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 0.2],
              colors: [Colors.black54, Colors.transparent],
            ),
            const _CustomGradient(
              begin: Alignment.topLeft,
              stops: [0.0, 0.3],
              colors: [Colors.black87, Colors.transparent],
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient({
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    required this.stops,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors,
          ),
        ),
      ),
    );
  }
}

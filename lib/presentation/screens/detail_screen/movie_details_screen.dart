import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinema_ui_flutter/presentation/providers/providers.dart';
import 'package:cinema_ui_flutter/config/constants/size_config.dart';
import 'package:cinema_ui_flutter/domain/entities/movie.dart';

import 'package:cinema_ui_flutter/presentation/screens/detail_screen/actors_section.dart';
import 'package:cinema_ui_flutter/presentation/screens/detail_screen/videos_youtube_section.dart';

class MovieDetailsScreen extends ConsumerStatefulWidget {
  final String id;
  final bool check;
  const MovieDetailsScreen({super.key, required this.id, this.check = false});

  @override
  MovieDetailsScreenState createState() => MovieDetailsScreenState();
}

class MovieDetailsScreenState extends ConsumerState<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.check == true) {
      ref.read(tvDetailsProvider.notifier).getTvById(widget.id);
    } else {
      ref.read(movieDetailProvider.notifier).getMovieById(widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    Movie? movie;
    if (widget.check == true) {
      movie = ref.watch(tvDetailsProvider)[widget.id];
    } else {
      movie = ref.watch(movieDetailProvider)[widget.id];
    }

    if (movie == null) {
      return const SizedBox(child: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie, check: widget.check),
          SliverList(
            delegate:
                SliverChildBuilderDelegate(childCount: 1, (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TitleMovie(movie: movie!),
                  _Genres(movie: movie),
                  if (!widget.check)
                    ActorsSection(movieId: movie.id.toString()),
                  if (widget.check == true) const SizedBox(height: 500),
                  if (!widget.check) VideosYoutube(movieId: movie.id),
                  const SizedBox(height: 100),
                ],
              );
            }),
          )
        ],
      ),
    );
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
  final bool check;
  const _CustomSliverAppBar({required this.movie, required this.check});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final favorites = ref.watch(favoritesProvider);
    final checkFavorite = favorites.indexWhere((e) => e.id == movie.id);

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: SizeConfig.screenHeight * 0.7,
      foregroundColor: Colors.white,
      actions: [
        if (!check)
          Center(
            child: IconButton(
              onPressed: () async {
                await ref
                    .read(favoritesProvider.notifier)
                    .toggleFavorite(movie);
              },
              icon: checkFavorite != -1
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

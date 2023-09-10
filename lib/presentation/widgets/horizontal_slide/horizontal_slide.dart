import 'package:animate_do/animate_do.dart';
import 'package:cinema_ui_flutter/domain/entities/movie.dart';
import 'package:cinema_ui_flutter/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HorizontalSlide extends StatefulWidget {
  final double width;
  final double height;
  final List<Movie> movies;
  final String title;
  final VoidCallback? loadNextPage;
  const HorizontalSlide({
    super.key,
    required this.movies,
    required this.width,
    this.height = 200,
    required this.title,
    this.loadNextPage,
  }) : assert(height < 300);

  @override
  State<HorizontalSlide> createState() => _HorizontalSlideState();
}

class _HorizontalSlideState extends State<HorizontalSlide> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      if ((_scrollController.position.pixels + 200) >=
          _scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomTitle(text: widget.title),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            itemCount: widget.movies.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final movie = widget.movies[index];
              return FadeInRight(
                child: _ItemMovie(
                  height: widget.height,
                  width: widget.width,
                  index: index,
                  movie: movie,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ItemMovie extends StatelessWidget {
  const _ItemMovie({
    required this.movie,
    required this.index,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;
  final Movie movie;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/details/${movie.id}');
      },
      child: Padding(
        padding: index == 0
            ? const EdgeInsets.only(left: 20, right: 20)
            : const EdgeInsets.only(right: 20),
        child: SizedBox(
          width: width,
          height: 200,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  alignment: Alignment.topCenter,
                  movie.posterPath,
                  fit: BoxFit.cover,
                  height: height,
                  width: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return CustomShimmer(
                        height: height,
                        width: double.infinity,
                      );
                    }
                    return FadeIn(child: child);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(TextSpan(
                          children: [
                            TextSpan(text: '${movie.voteAverage}'),
                            const WidgetSpan(
                              child: Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Icon(
                                  Icons.star,
                                  size: 18,
                                  color: Colors.yellow,
                                ),
                              ),
                            ),
                          ],
                        )),
                        Text('${movie.voteCount}.k')
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

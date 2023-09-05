import 'package:animate_do/animate_do.dart';
import 'package:cinema_ui_flutter/domain/entities/movie.dart';
import 'package:cinema_ui_flutter/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HorizontalSlide extends StatelessWidget {
  final double width;
  final double height;
  final List<Movie> movies;
  final String title;
  const HorizontalSlide({
    super.key,
    required this.movies,
    required this.width,
    this.height = 200,
    required this.title,
  }) : assert(height < 300);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomTitle(text: title),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: movies.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () {},
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
                            movie.posterPath,
                            fit: BoxFit.cover,
                            height: height,
                            width: double.infinity,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress != null) {
                                return const CustomShimmer(
                                  height: 200,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
            },
          ),
        ),
      ],
    );
  }
}

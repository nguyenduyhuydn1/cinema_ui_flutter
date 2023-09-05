import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinema_ui_flutter/presentation/providers/movies/movies_provider.dart';
import 'package:cinema_ui_flutter/presentation/providers/movies/slide_show_provider.dart';

import 'package:cinema_ui_flutter/presentation/widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingProvider.notifier).loadNextPage();
    ref.read(popularProvider.notifier).loadNextPage();
    ref.read(topRatedProvider.notifier).loadNextPage();
    ref.read(upComingProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final slide = ref.watch(slideShowProvider);
    // final nowPlaying = ref.watch(nowPlayingProvider);
    final popular = ref.watch(popularProvider);
    final topRated = ref.watch(topRatedProvider);
    final upComing = ref.watch(upComingProvider);
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.black45,
          title: const Text("TMDB"),
          elevation: 0,
          actions: [
            CustomButton(icon: Icons.search, onpressed: () {}),
            const SizedBox(width: 15)
          ],
          floating: true,
          // pinned: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(childCount: 1, (context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SlideShow(listSlide: slide),
                ),
                HorizontalSlide(
                    title: "Popular", movies: popular.movies, width: 150),
                const SizedBox(height: 15),
                HorizontalSlide(
                  title: "Top Rated",
                  movies: topRated.movies,
                  width: 300,
                  height: 190,
                ),
                HorizontalSlide(
                  title: "Up Coming",
                  movies: upComing.movies,
                  width: 300,
                  height: 190,
                ),
                const SizedBox(height: 100)
              ],
            );
          }),
        )
      ],
    );
  }
}

import 'package:cinema_ui_flutter/presentation/delegates/search_movie_delegate.dart';
import 'package:cinema_ui_flutter/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final initialLoading = ref.watch(initialLoadingMoviesProvider);
    if (initialLoading) {
      return const SizedBox(child: Center(child: CircularProgressIndicator()));
    }

    final slide = ref.watch(slideShowProvider);
    final popular = ref.watch(popularProvider);
    final topRated = ref.watch(topRatedProvider);
    final upComing = ref.watch(upComingProvider);

    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        const _AppBar(),
        SliverList(
          delegate: SliverChildBuilderDelegate(childCount: 1, (context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SlideShow(listSlide: slide),
                ),
                HorizontalSlide(
                  title: "Popular",
                  movies: popular.movies,
                  width: 150,
                  loadNextPage: () =>
                      ref.read(popularProvider.notifier).loadNextPage(),
                ),
                const SizedBox(height: 15),
                HorizontalSlide(
                  title: "Top Rated",
                  movies: topRated.movies,
                  width: 300,
                  height: 190,
                  loadNextPage: () =>
                      ref.read(topRatedProvider.notifier).loadNextPage(),
                ),
                HorizontalSlide(
                  title: "Up Coming",
                  movies: upComing.movies,
                  width: 300,
                  height: 190,
                  loadNextPage: () =>
                      ref.read(upComingProvider.notifier).loadNextPage(),
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

class _AppBar extends ConsumerWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      backgroundColor: Colors.black45,
      title: const Text("TMDB"),
      elevation: 0,
      actions: [
        CustomButton(
            icon: Icons.search,
            onpressed: () {
              final searchedMovie = ref.read(searchedMoviesProvider);
              final searchQuery = ref.read(searchQueryProvider);

              showSearch(
                query: searchQuery,
                context: context,
                delegate: SearchMovieDelegates(
                  searchQuery: ref
                      .read(searchedMoviesProvider.notifier)
                      .searchMoviesByQuery,
                  initialMovies: searchedMovie,
                ),
              );
            }),
        const SizedBox(width: 15)
      ],
      floating: true,
      // pinned: true,
    );
  }
}

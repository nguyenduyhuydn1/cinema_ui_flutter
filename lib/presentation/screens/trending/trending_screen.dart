import 'package:cinema_ui_flutter/domain/entities/movie.dart';
import 'package:cinema_ui_flutter/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:cinema_ui_flutter/presentation/providers/providers.dart';

class TrendingScreen extends ConsumerStatefulWidget {
  final VoidCallback? loadNextPage;
  final String text;
  const TrendingScreen({
    super.key,
    required this.text,
    this.loadNextPage,
  });

  @override
  TrendingScreenState createState() => TrendingScreenState();
}

class TrendingScreenState extends ConsumerState<TrendingScreen> {
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
    List<Movie> movies = [];
    bool isLoading = false;

    if (widget.text == 'Popular') {
      movies = ref.watch(popularProvider).movies;
      isLoading = ref.watch(popularProvider).isLoading;
    }
    if (widget.text == 'Top Rated') {
      movies = ref.watch(topRatedProvider).movies;
      isLoading = ref.watch(topRatedProvider).isLoading;
    }
    if (widget.text == 'Up Coming') {
      movies = ref.watch(upComingProvider).movies;
      isLoading = ref.watch(upComingProvider).isLoading;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.text),
        centerTitle: true,
      ),
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: ((OverscrollIndicatorNotification? notification) {
            notification!.disallowIndicator();
            return true;
          }),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1 / 2,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];

                    return GestureDetector(
                      onTap: () {
                        context.push('/details/${movie.id}');
                      },
                      child: Image.network(
                        movie.posterPath,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress != null) {
                            return const CustomShimmer(
                              height: double.infinity,
                              width: double.infinity,
                            );
                          }
                          return child;
                        },
                      ),
                    );
                  },
                ),
              ),
              if (isLoading == true)
                const SizedBox(
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

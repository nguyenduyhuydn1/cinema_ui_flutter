import 'package:cinema_ui_flutter/presentation/providers/movies/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

class CategoriesView extends ConsumerStatefulWidget {
  final VoidCallback onPressed;
  const CategoriesView({
    super.key,
    required this.onPressed,
  });

  @override
  CategoriesViewState createState() => CategoriesViewState();
}

class CategoriesViewState extends ConsumerState<CategoriesView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(tvSeriesProvider.notifier).loadNextPage();

    _scrollController.addListener(() {
      if ((_scrollController.position.pixels + 200) >=
          _scrollController.position.maxScrollExtent) {
        ref.read(tvSeriesProvider.notifier).loadNextPage();
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
    final tvSeries = ref.watch(tvSeriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("TV Series Today"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => widget.onPressed(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: ((OverscrollIndicatorNotification? notification) {
                notification!.disallowIndicator();
                return true;
              }),
              child: MasonryGridView.builder(
                controller: _scrollController,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemCount: tvSeries.movies.length,
                itemBuilder: (context, index) {
                  final item = tvSeries.movies[index];

                  return GestureDetector(
                    onTap: () {
                      context.push('/tv/details/${item.id}');
                    },
                    child: ClipRRect(
                      child: Image.network(
                        item.posterPath,
                        height: (index % 5 + 1) * 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (tvSeries.isLoading == true)
            const SizedBox(
              height: 100,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
        ],
      ),
    );
  }
}

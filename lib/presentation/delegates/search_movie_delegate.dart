import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:cinema_ui_flutter/domain/entities/movie.dart';

class SearchProductDelegates extends SearchDelegate {
  final Future<List<Movie>> Function(String query) searchQuery;
  List<Movie> initialProducts;

  SearchProductDelegates(
      {required this.searchQuery, required this.initialProducts})
      : super(
          searchFieldLabel: "Search Product",
          // textInputAction: TextInputAction.done
          // searchFieldStyle: const TextStyle(color: Colors.red),
        );

  //deboucing
  // broadcast lang nghe hon 1 lan
  StreamController<List<Movie>> debounceProducts = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  Timer? _debounceTimer;

  void clearStream() async {
    await Future.delayed(const Duration(milliseconds: 500));
    debounceProducts.close();
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      final products = await searchQuery(query);
      initialProducts = products;
      debounceProducts.add(products);
      isLoadingStream.add(false);
    });
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialProducts,
      stream: debounceProducts.stream,
      builder: (context, snapshot) {
        final products = snapshot.data ?? [];

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) => _ProductItem(
            item: products[index],
            onProductSelected: (context, item) {
              clearStream();
              close(context, item);
            },
          ),
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              child: IconButton(
                  onPressed: () => query = '',
                  icon: const Icon(Icons.refresh_rounded)),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
              onPressed: () => query = '',
              icon: const Icon(Icons.clear),
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStream();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildResultsAndSuggestions();
  }
}

class _ProductItem extends StatelessWidget {
  const _ProductItem({
    required this.item,
    required this.onProductSelected,
  });

  final Function onProductSelected;
  final Movie item;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        context.push('/product/${item.id}');
        onProductSelected(context, item);
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //images
            SizedBox(
              width: size.width * 0.4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  item.posterPath,
                  height: 150,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    return FadeIn(child: child);
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            //text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "${item.title} \n".toUpperCase(),
                      style: textStyle.titleMedium?.copyWith(
                        fontSize: 15,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    //  RichText(
                    //   text: TextSpan(
                    //     children: [
                    //       TextSpan(
                    //         text: "${item.name} \n".toUpperCase(),
                    //         style:
                    //             textStyle.titleMedium?.copyWith(fontSize: 17),
                    //       ),
                    //       TextSpan(
                    //         text: item.brand,
                    //         style: textStyle.titleMedium?.copyWith(
                    //           fontSize: 17,
                    //           color: Colors.green,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ),
                  Text(
                    item.title,
                    style: textStyle.titleMedium?.copyWith(
                      fontSize: 17,
                      color: Colors.green,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text('\$${item.title}',
                        style: textStyle.titleMedium?.copyWith(
                          fontSize: 17,
                          color: Colors.green,
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

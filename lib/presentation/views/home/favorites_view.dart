import 'package:animate_do/animate_do.dart';
import 'package:cinema_ui_flutter/domain/entities/movie.dart';
import 'package:cinema_ui_flutter/presentation/providers/storage/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    super.initState();
    ref.read(favoritesProvider.notifier).getDataFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final favoritesState = ref.watch(favoritesProvider);

    return MasonryGridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemCount: favoritesState.length,
      itemBuilder: (context, index) {
        final favorite = favoritesState[index];

        return FadeInDown(child: _Item(favorite: favorite));
      },
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.favorite,
  });

  final Movie favorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/details/${favorite.id}');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          favorite.posterPath,
          width: 150,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

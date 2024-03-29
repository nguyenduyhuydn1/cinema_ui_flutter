import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinema_ui_flutter/domain/entities/movie.dart';

import 'package:cinema_ui_flutter/presentation/providers/intro/initial_loading_provider.dart';
import 'package:cinema_ui_flutter/presentation/providers/intro/intro_provider.dart';

import 'package:go_router/go_router.dart';

import 'button_intro.dart';

class IntroScreen extends ConsumerStatefulWidget {
  const IntroScreen({super.key});

  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends ConsumerState<IntroScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(introProvider1.notifier).loadIntro(page: 5);
    ref.read(introProvider2.notifier).loadIntro(page: 6);
    ref.read(introProvider3.notifier).loadIntro(page: 7);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingIntroProvider);
    if (initialLoading) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    final List<Movie> intro1 = ref.watch(introProvider1).movies;
    final List<Movie> intro2 = ref.watch(introProvider2).movies;
    final List<Movie> intro3 = ref.watch(introProvider3).movies;

    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: _ListProducts(
                  intro: intro1,
                  seconds: 40,
                ),
              ),
              Expanded(
                child: _ListProducts(
                  intro: intro2,
                  seconds: 45,
                  quarterTurns: 2,
                ),
              ),
              Expanded(
                child: _ListProducts(
                  intro: intro3,
                  seconds: 50,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.black54,
                    Colors.black54,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.1, 0.5, 0.8, 1],
                ),
              ),
              child: Center(
                child: UnicornOutlineButton(
                  strokeWidth: 2,
                  radius: 30,
                  gradient:
                      const LinearGradient(colors: [Colors.blue, Colors.pink]),
                  child: const Text('Go Home', style: TextStyle(fontSize: 16)),
                  onPressed: () {
                    context.go('/');
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ListProducts extends ConsumerStatefulWidget {
  final List<Movie> intro;
  final int seconds;
  final int quarterTurns;
  const _ListProducts({
    required this.intro,
    this.seconds = 25,
    this.quarterTurns = 0,
  });

  @override
  ListProductsState createState() => ListProductsState();
}

class ListProductsState extends ConsumerState<_ListProducts> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      double maxScrollExtent = _scrollController.position.maxScrollExtent;
      double minScrollExtent = _scrollController.position.minScrollExtent;

      animateToMaxMin(
        maxScrollExtent,
        minScrollExtent,
        maxScrollExtent,
        widget.seconds,
        _scrollController,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  animateToMaxMin(double max, double min, double direction, int seconds,
      ScrollController scrollController) {
    scrollController
        .animateTo(direction,
            duration: Duration(seconds: seconds), curve: Curves.linear)
        .then(
      (value) {
        direction = direction == max ? min : max;
        if (scrollController.hasClients) {
          animateToMaxMin(max, min, direction, seconds, scrollController);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: widget.quarterTurns,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.intro.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = widget.intro[index];
          return Padding(
            padding: const EdgeInsets.all(5),
            child: RotatedBox(
              quarterTurns: widget.quarterTurns,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  item.posterPath,
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

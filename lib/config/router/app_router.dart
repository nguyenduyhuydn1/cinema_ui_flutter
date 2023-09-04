import 'package:go_router/go_router.dart';

import 'package:cinema_ui_flutter/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/intro',
  routes: [
    GoRoute(
      path: '/intro',
      builder: (context, state) {
        return const IntroScreen();
      },
    ),
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/',
      redirect: (_, __) => '/',
    ),
  ],
);

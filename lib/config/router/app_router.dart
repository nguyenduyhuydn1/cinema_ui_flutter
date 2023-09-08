import 'package:go_router/go_router.dart';
import 'package:cinema_ui_flutter/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
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
      path: '/details/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return MovieDetailsScreen(id: id);
      },
    ),
    GoRoute(
      path: '/',
      redirect: (_, __) => '/',
    ),
  ],
);

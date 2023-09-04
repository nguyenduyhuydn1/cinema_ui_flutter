import 'package:cinema_ui_flutter/presentation/screens/home/home_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
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

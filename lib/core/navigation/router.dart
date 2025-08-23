import 'package:go_router/go_router.dart';
import 'package:tc_sa/core/index.dart';

class Router {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/', name: RouteNames.splash),
      ShellRoute(
        routes: [
          GoRoute(path: '/home', name: RouteNames.home),
          GoRoute(path: '/blogs', name: RouteNames.blogs),
          GoRoute(path: '/services', name: RouteNames.services),
          GoRoute(path: '/shortlist', name: RouteNames.shortlist),
        ],
      ),
    ],
  );
}

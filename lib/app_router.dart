import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';
import 'screens/home_screen.dart';
import 'screens/order_screen.dart';

/// Exposes the GoRouter configured for the entire application.
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: RoutesPath.home,
        name: RouteNames.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: RoutesPath.order,
        name: RouteNames.order,
        builder: (context, state) => const OrderScreen(),
      ),
    ],
  );
});

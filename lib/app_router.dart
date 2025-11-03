import 'package:go_router/go_router.dart';

import 'routes.dart';
import 'screens/home_screen.dart';
import 'screens/order_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: RoutePaths.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RoutePaths.order,
      builder: (context, state) => const OrderScreen(),
    ),
  ],
);

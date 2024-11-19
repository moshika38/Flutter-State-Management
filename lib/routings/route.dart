import 'package:flutter_application_1/screen/cart_screen.dart';
import 'package:flutter_application_1/screen/fav_screen.dart';
import 'package:go_router/go_router.dart';
import '../screen/home_screen.dart';

class AppRoute {
  GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: "home",
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/fav',
        name: "fav",
        builder: (context, state) => const FavScreen(),
      ),
      GoRoute(
        path: '/cart',
        name: "cart",
        builder: (context, state) => const CartScreen(),
      ),
    ],
  );
}

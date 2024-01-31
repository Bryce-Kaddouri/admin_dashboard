import 'package:admin_dashboard/src/feature/auth/presentation/provider/auth_provider.dart';
import 'package:admin_dashboard/src/feature/home/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../feature/auth/presentation/screen/signin_screen.dart';
import '../../feature/category/presentation/screen/update_category_screen.dart';

/*class Routes {
  static const String home = '/home';
  static const String login = '/login';

  final getPages = [
    GetPage(
      participatesInRootNavigator: true,
      name: Routes.home,
      page: () => HomeScreen(),
      transition: Transition.zoom,
      children: [],
    ),
    GetPage(
      participatesInRootNavigator: true,
      name: Routes.login,
      page: () => SignInScreen(),
      transition: Transition.zoom,
      children: [],
    ),
  ];
}*/

class RouterHelper {
  GoRouter getRouter() {
    return GoRouter(
      navigatorKey: Get.key,
      redirect: (context, state) {
        // check if user is logged in
        // if not, redirect to login page

        print('state: ${state.matchedLocation}');
        print('state: ${state.uri}');

        bool isLoggedIn = context.read<AuthProvider>().checkIsLoggedIn();
        print('isLoggedIn: $isLoggedIn');

        if (!isLoggedIn && state.uri.path != '/login') {
          return '/login';
        } else {
          return state.uri.path;
        }
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => HomeScreen(
            currentIndex: 0,
          ),
        ),
        GoRoute(
          path: '/category-list',
          builder: (context, state) => HomeScreen(
            currentIndex: 1,
          ),
        ),
        GoRoute(
          path: '/category-add',
          builder: (context, state) => HomeScreen(
            currentIndex: 2,
          ),
        ),
        GoRoute(
            path: '/category-update/:id',
            builder: (context, state) {
              String? id = state.pathParameters['id'];
              if (id == null) {
                return Scaffold(
                  body: Center(
                    child: Text('Category Not found'),
                  ),
                );
              } else {
                int idInt = int.parse(id);
                return UpdateCategoryScreen(
                  categoryId: idInt,
                );
              }
            }),
        GoRoute(
          path: '/product-list',
          builder: (context, state) => HomeScreen(
            currentIndex: 3,
          ),
        ),
        GoRoute(
          path: '/product-add',
          builder: (context, state) => HomeScreen(
            currentIndex: 4,
          ),
        ),
        GoRoute(
          path: '/order-list',
          builder: (context, state) => HomeScreen(
            currentIndex: 5,
          ),
        ),
        GoRoute(
          path: '/user-list',
          builder: (context, state) => HomeScreen(
            currentIndex: 6,
          ),
        ),
        GoRoute(
          path: '/user-add',
          builder: (context, state) => HomeScreen(
            currentIndex: 7,
          ),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => SignInScreen(),
        ),
      ],
    );
  }
}

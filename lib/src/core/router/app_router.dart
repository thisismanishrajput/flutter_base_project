import 'package:clean_arch_base/src/core/constants/app_strings.dart';
import 'package:clean_arch_base/src/core/di/injection_container.dart';
import 'package:clean_arch_base/src/core/network/auth_session_manager.dart';
import 'package:clean_arch_base/src/core/router/app_route_paths.dart';
import 'package:clean_arch_base/src/core/router/route_placeholder_page.dart';
import 'package:clean_arch_base/src/features/auth/presentation/pages/login_page.dart';
import 'package:clean_arch_base/src/features/products/presentation/pages/products_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Centralized GoRouter configuration for app navigation.
class AppRouter {
  const AppRouter._();

  /// Root navigator key for global navigation operations.
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  /// Application router instance.
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutePaths.products,
    refreshListenable: sl<AuthSessionManager>(),
    redirect: (BuildContext context, GoRouterState state) {
      final isLoggedIn = sl<AuthSessionManager>().isLoggedIn;
      final isLoginRoute = state.uri.path == AppRoutePaths.login;

      if (!isLoggedIn && !isLoginRoute) {
        return AppRoutePaths.login;
      }
      if (isLoggedIn && isLoginRoute) {
        return AppRoutePaths.products;
      }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutePaths.login,
        name: AppRouteNames.login,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: AppRoutePaths.products,
        name: AppRouteNames.products,
        builder: (BuildContext context, GoRouterState state) {
          return const ProductsPage();
        },
      ),
      GoRoute(
        path: AppRoutePaths.settings,
        name: AppRouteNames.settings,
        builder: (BuildContext context, GoRouterState state) {
          return const RoutePlaceholderPage(
            title: AppStrings.settingsTitle,
            message: AppStrings.settingsPlaceholderMessage,
          );
        },
      ),
    ],
    errorBuilder: (BuildContext context, GoRouterState state) {
      return RoutePlaceholderPage(
        title: AppStrings.pageNotFound,
        message:
            '${AppStrings.routeNotFoundMessagePrefix} "${state.uri.path}". ${AppStrings.routeNotFoundMessageSuffix}',
      );
    },
  );
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:flutter_base_project/features/home/presentation/view/home_screen.dart';
import 'package:flutter_base_project/features/orders/presentation/view/orders_screen.dart';
import 'package:flutter_base_project/features/root/presentation/widget/navigation_screen.dart';
import 'package:flutter_base_project/features/user-onboard/presentation/view/login_screen.dart';
import 'package:flutter_base_project/features/user-onboard/presentation/view/otp_screen.dart';
import 'package:flutter_base_project/features/user-onboard/presentation/view/signp_screen.dart';
import 'package:flutter_base_project/features/user-onboard/presentation/view/splash_page.dart';
import 'package:flutter_base_project/utility/common_widgets/not_found_page.dart';
import 'route_observer.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: SplashPage.path,
  navigatorKey: navigatorKey,
  observers: [
    GoRouterObserver(),
    defaultLifecycleObserver,
    routeObserver,
  ],
  errorBuilder: (context, state) {
    return const NotFoundPage();
  },
  routes: [
    GoRoute(
      path: SplashPage.path,
      name: SplashPage.routeName,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: LoginScreen.path,
      name: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: OtpScreen.path,
      name: OtpScreen.routeName,
      builder: (context, state) {
        final verificationId = state.extra as String?; // Retrieve the passed verificationId
        return OtpScreen(verificationId: verificationId ?? "");
      },
    ),
    GoRoute(
      path: SignupScreen.path,
      name: SignupScreen.routeName,
      builder: (context, state) => const SignupScreen(),
    ),
    // Parent Route (After Login) with Nested Routes
    ShellRoute(
      builder: (context, state, child) {
        return const Home();
      },
      routes: [
        GoRoute(
          path: HomeScreen.path,
          name: HomeScreen.routeName,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: OrdersScreen.path,
          name: OrdersScreen.routeName,
          builder: (context, state) => const OrdersScreen(),
        ),
      ],
    ),
  ],
);

FutureOr<String?> _loginRedirect(context, state) {
  if (state.extra == null) {
    return LoginScreen.path;
  } else {
    return null;
  }
}

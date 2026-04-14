import 'package:clean_arch_base/src/core/config/app_environment.dart';
import 'package:clean_arch_base/src/core/di/injection_container.dart';
import 'package:clean_arch_base/src/core/router/app_router.dart';
import 'package:clean_arch_base/src/core/theme/app_theme.dart';
import 'package:clean_arch_base/src/core/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>.value(
      value: sl<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (BuildContext context, ThemeMode themeMode) {
          return MaterialApp.router(
            title: AppEnvironment.instance.appName,
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}

import 'package:clean_arch_base/src/core/storage/shared_pref_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Global theme cubit that controls app light/dark mode.
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit({required SharedPrefService sharedPrefService})
    : _sharedPrefService = sharedPrefService,
      super(_resolveInitialTheme(sharedPrefService));

  final SharedPrefService _sharedPrefService;

  /// Toggles the theme mode and persists the choice.
  Future<void> toggleTheme() async {
    final nextMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(nextMode);
    await _sharedPrefService.saveIsDarkMode(nextMode == ThemeMode.dark);
  }

  /// Explicitly sets theme mode and persists the choice.
  Future<void> setTheme(ThemeMode mode) async {
    emit(mode);
    await _sharedPrefService.saveIsDarkMode(mode == ThemeMode.dark);
  }

  static ThemeMode _resolveInitialTheme(SharedPrefService sharedPrefService) {
    final isDarkMode = sharedPrefService.getIsDarkMode();
    if (isDarkMode == null) {
      return ThemeMode.system;
    }
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }
}

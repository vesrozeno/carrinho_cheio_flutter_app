import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carrinho_cheio/core/storage/theme_storage.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit({required this._themeStorage}) : super(ThemeMode.light);

  final ThemeStorage _themeStorage;

  Future<void> initialize() async {
    final savedTheme = await _themeStorage.getSavedTheme();
    emit(savedTheme);
  }

  Future<void> toggleTheme() async {
    final newTheme = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await _themeStorage.saveTheme(newTheme);
    emit(newTheme);
  }

  Future<void> setTheme(ThemeMode theme) async {
    await _themeStorage.saveTheme(theme);
    emit(theme);
  }

  bool get isDarkMode => state == ThemeMode.dark;
  bool get isLightMode => state == ThemeMode.light;
}

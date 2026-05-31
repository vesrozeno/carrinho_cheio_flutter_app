import 'package:carrinho_cheio/core/errors/app_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ThemeStorage {
  ThemeStorage({required this._secureStorage});

  final FlutterSecureStorage _secureStorage;
  static const _themeKey = 'app_theme';

  Future<ThemeMode> getSavedTheme() async {
    try {
      final theme = await _secureStorage.read(key: _themeKey);
      if (theme == null) return ThemeMode.light;

      return theme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    } catch (e) {
      return ThemeMode.light;
    }
  }

  Future<void> saveTheme(ThemeMode theme) async {
    try {
      final themeValue = theme == ThemeMode.dark ? 'dark' : 'light';
      await _secureStorage.write(key: _themeKey, value: themeValue);
    } catch (e) {
      throw AppException('Erro ao salvar tema do app');
    }
  }
}

import 'package:flutter/material.dart';
import '../navigator/app_navigator.dart';

class ScreenSize {
  ScreenSize._();

  static MediaQueryData get _mediaQuery => MediaQuery.of(AppNavigator.context);

  static double get width => _mediaQuery.size.width;
  static double get height => _mediaQuery.size.height;
  static double get statusBar => _mediaQuery.padding.top;
  static double get bottomBar => _mediaQuery.padding.bottom;
  static double get safeHeight => height - statusBar - bottomBar;
  static bool get isSmallDevice => width < 360;
  static bool get isTablet => width >= 600;
}

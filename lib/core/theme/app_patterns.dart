import 'package:carrinho_cheio/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppPatterns {
  AppPatterns._();
  static final List<BoxShadow> boxShadow = [
    BoxShadow(
      color: AppColors.black.withAlpha(128),
      blurRadius: 10,
      offset: Offset(0, 5),
    ),
  ];
}

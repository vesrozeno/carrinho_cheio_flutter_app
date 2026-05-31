import 'package:carrinho_cheio/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

enum ToastType {
  success,
  error,
}

extension ToastTypeExtension on ToastType {
  Color get color {
    switch (this) {
      case ToastType.success:
        return AppColors.successGreen;
      case ToastType.error:
        return AppColors.errorRed;
    }
  }

  IconData get icon {
    switch (this) {
      case ToastType.success:
        return Icons.check_circle_outline;
      case ToastType.error:
        return Icons.error_outline;
    }
  }
}

class AppToast {
  AppToast._();

  static void show({
    required ToastType type,
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    toastification.show(
      alignment: Alignment.bottomCenter,
      autoCloseDuration: duration,
      dragToClose: true,
      closeOnClick: false,
      showProgressBar: false,
      applyBlurEffect: false,
      backgroundColor: type.color,
      foregroundColor: AppColors.white,
      borderRadius: BorderRadius.circular(16),

      margin: const EdgeInsets.symmetric(horizontal: 16),

      icon: Icon(
        type.icon,
        color: AppColors.white,
      ),

      title: Text(
        message,
        style: const TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),

      closeButton: ToastCloseButton(
        showType: CloseButtonShowType.always,
      ),
    );
  }

  static void showSuccess({
    required String message,
  }) {
    show(
      type: ToastType.success,
      message: message,
    );
  }

  static void showError({
    required String message,
  }) {
    show(
      type: ToastType.error,
      message: message,
    );
  }
}

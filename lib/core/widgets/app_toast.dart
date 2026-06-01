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
      style: ToastificationStyle.flat,
      autoCloseDuration: duration,
      dragToClose: true,
      closeOnClick: true,
      showProgressBar: false,
      applyBlurEffect: false,
      backgroundColor: type.color,
      borderRadius: BorderRadius.circular(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
        buttonBuilder: (context, onClose) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onClose,
              borderRadius: BorderRadius.circular(20),
              splashColor: Colors.white.withValues(alpha: 0.15),
              highlightColor: Colors.white.withValues(alpha: 0.08),
              child: const SizedBox(
                width: 28,
                height: 28,
                child: Center(
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
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

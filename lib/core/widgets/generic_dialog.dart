import 'package:carrinho_cheio/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class GenericDialog extends StatefulWidget {
  final String title;
  final IconData? icon;
  final Widget content;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final String confirmButtonText;
  final bool isLoading;
  final IconData? confirmButtonIcon;

  const GenericDialog({
    super.key,
    required this.title,
    required this.content,
    required this.confirmButtonText,
    required this.onConfirm,
    this.icon,
    this.onCancel,
    this.isLoading = false,
    this.confirmButtonIcon,
  });

  static Future<void> show({
    required BuildContext context,
    required String title,
    required Widget content,
    required String confirmButtonText,
    required VoidCallback? onConfirm,
    VoidCallback? onCancel,
    IconData? icon,
    bool isLoading = false,
    IconData? confirmButtonIcon,
    bool barrierDismissible = true,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) {
        return GenericDialog(
          title: title,
          content: content,
          confirmButtonText: confirmButtonText,
          onConfirm: onConfirm,
          icon: icon,
          isLoading: isLoading,
          confirmButtonIcon: confirmButtonIcon,
        );
      },
    );
  }

  @override
  State<GenericDialog> createState() => _GenericDialogState();
}

class _GenericDialogState extends State<GenericDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleConfirm() {
    final isValid = _formKey.currentState?.validate() ?? true;

    if (!isValid) {
      return;
    }

    widget.onConfirm?.call();

    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(24, 20, 12, 0),
      insetPadding: const EdgeInsets.symmetric(horizontal: 15),
      contentPadding: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Row(
        children: [
          if (widget.icon != null) ...[
            Icon(widget.icon),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(widget.title),
          ),
          IconButton(
            onPressed: () {
              widget.onCancel?.call();
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: SizedBox(
        width: 420,

        child: Form(
          key: _formKey,
          child: widget.content,
        ),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      actions: [
        Center(
          child: CustomElevatedButton(
            onPressed: _handleConfirm,
            isLoading: widget.isLoading,
            prefixIcon: widget.confirmButtonIcon,
            child: Text(
              widget.confirmButtonText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

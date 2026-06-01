import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final IconData? prefixIcon;
  final bool isLoading;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.prefixIcon,
    this.isLoading = false,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  bool _internalLoading = false;

  Future<void> _handlePressed() async {
    if (widget.onPressed == null) return;

    setState(() {
      _internalLoading = true;
    });

    try {
      widget.onPressed!();
    } finally {
      if (mounted) {
        setState(() {
          _internalLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = widget.isLoading || _internalLoading;

    return ElevatedButton(
      onPressed: loading ? null : _handlePressed,
      style: ElevatedButton.styleFrom(
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: loading
          ? const SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : widget.prefixIcon != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.prefixIcon),
                const SizedBox(width: 8),
                widget.child,
              ],
            )
          : widget.child,
    );
  }
}

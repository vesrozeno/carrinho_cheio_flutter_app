import 'package:carrinho_cheio/core/widgets/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showWillPopScopeDialog(BuildContext context) async {
  final shouldExit = await showDialog<bool>(
    context: context,
    builder: (context) {
      return GenericDialog(
        title: 'Sair do app',
        content: const Text('Tem certeza que deseja sair do aplicativo?'),
        onCancel: () => Navigator.of(context).pop(false),
        onConfirm: () => Navigator.of(context).pop(true),
        icon: Icons.logout,
        confirmButtonText: 'Sair',
      );
    },
  );

  return shouldExit ?? false;
}

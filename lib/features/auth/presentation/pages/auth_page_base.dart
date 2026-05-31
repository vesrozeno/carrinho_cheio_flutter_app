import 'package:carrinho_cheio/core/navigator/app_navigator.dart';
import 'package:carrinho_cheio/core/theme/app_colors.dart';
import 'package:carrinho_cheio/core/theme/app_patterns.dart';
import 'package:carrinho_cheio/core/widgets/app_toast.dart';
import 'package:carrinho_cheio/core/widgets/custom_elevated_button.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_state.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_status_enum.dart';
import 'package:carrinho_cheio/features/auth/presentation/pages/login_page.dart';
import 'package:carrinho_cheio/features/lists/presentation/pages/lists_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPageBase extends StatefulWidget {
  const AuthPageBase({
    super.key,
    required this.topText,
    required this.buttonText,
    required this.bottomText,
    required this.bottomActionText,
    required this.mainContext,
    required this.onButtonPressed,
    required this.onActionTextPressed,
  });

  final String topText;
  final String buttonText;
  final String bottomText;
  final String bottomActionText;
  final Widget mainContext;
  final VoidCallback? onButtonPressed;
  final VoidCallback? onActionTextPressed;

  @override
  State<AuthPageBase> createState() => _AuthPageBaseState();
}

class _AuthPageBaseState extends State<AuthPageBase> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => current.status != previous.status,
      listener: (context, state) {
        switch (state.status) {
          case AuthStatus.error:
            AppToast.showError(message: state.message ?? 'Erro ao autenticar');
          case AuthStatus.authenticated:
            AppToast.showSuccess(message: 'Login realizado com sucesso');
            AppNavigator.pushAndRemoveUntil(ListsHomePage());
            break;
          case AuthStatus.registered:
            AppToast.showSuccess(message: 'Cadastro realizado com sucesso');
            AppNavigator.pushAndRemoveUntil(LoginPage());
            break;
          case AuthStatus.loading:
          case AuthStatus.initial:
          case AuthStatus.unauthenticated:
            break;
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final bool isLoading = state.status == AuthStatus.loading;
          return Scaffold(
            body: Container(
              color: AppColors.primary,
              child: AbsorbPointer(
                absorbing: isLoading,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 420,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 20,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                'assets/logo.png',
                                height: 150,
                              ),
                              Text(
                                "Seu app para listas de compras!",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context).cardColor,
                              boxShadow: AppPatterns.boxShadow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              spacing: 15,
                              children: [
                                Text(
                                  widget.topText,
                                  style: TextStyle(fontSize: 12),
                                ),

                                widget.mainContext,

                                CustomElevatedButton(
                                  onPressed: widget.onButtonPressed,
                                  isLoading: isLoading,
                                  child: isLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        )
                                      : Text(widget.buttonText),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.bottomText,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(20),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(20),
                                        onTap: isLoading ? null : widget.onActionTextPressed,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          child: Text(
                                            widget.bottomActionText,
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

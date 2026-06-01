import 'package:carrinho_cheio/core/navigator/app_navigator.dart';
import 'package:carrinho_cheio/core/theme/app_colors.dart';
import 'package:carrinho_cheio/core/theme/app_patterns.dart';
import 'package:carrinho_cheio/core/theme/theme_cubit.dart';
import 'package:carrinho_cheio/core/widgets/app_toast.dart';
import 'package:carrinho_cheio/core/widgets/custom_elevated_button.dart';
import 'package:carrinho_cheio/core/widgets/will_pop_scope.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_state.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_status_enum.dart';
import 'package:carrinho_cheio/features/auth/presentation/pages/login_page.dart';
import 'package:carrinho_cheio/features/lists/presentation/bloc/lists.bloc.dart';
import 'package:carrinho_cheio/features/lists/presentation/bloc/lists_event.dart';
import 'package:carrinho_cheio/features/lists/presentation/pages/lists_home_page.dart';
import 'package:carrinho_cheio/injection/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBasePage extends StatefulWidget {
  const AuthBasePage({
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
  State<AuthBasePage> createState() => _AuthBasePageState();
}

class _AuthBasePageState extends State<AuthBasePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case AuthStatus.authenticated:
            getIt<ListsBloc>().add(LoadListsEvent());
            AppNavigator.pushAndRemoveUntil(ListsHomePage());
            break;
          case AuthStatus.registered:
            AppToast.show(type: ToastType.success, message: 'Cadastro realizado com sucesso!');
            AppNavigator.pushAndRemoveUntil(LoginPage());
            break;
          case AuthStatus.error:
          case AuthStatus.loading:
          case AuthStatus.initial:
          case AuthStatus.unauthenticated:
            break;
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final bool isLoading = state.status == AuthStatus.loading;

          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) async {
              if (didPop) return;

              final shouldPop = await showWillPopScopeDialog(context);
              if (shouldPop && context.mounted) {
                SystemNavigator.pop();
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Container(
                          color: getIt<ThemeCubit>().isDarkMode ? AppColors.backgroundDark : AppColors.primary,
                          child: AbsorbPointer(
                            absorbing: isLoading,
                            child: Center(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 420,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: 20,
                                    children: [
                                      Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/logo.png',
                                            height: 150,
                                          ),
                                          const Text(
                                            "Seu app para listas de compras!",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(15),
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
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                            widget.mainContext,
                                            CustomElevatedButton(
                                              onPressed: widget.onButtonPressed,
                                              isLoading: isLoading,
                                              child: isLoading
                                                  ? const SizedBox(
                                                      width: 20,
                                                      height: 20,
                                                      child: CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                      ),
                                                    )
                                                  : Text(widget.buttonText),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  widget.bottomText,
                                                  style: const TextStyle(fontSize: 12),
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
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12,
                                                        ),
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
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

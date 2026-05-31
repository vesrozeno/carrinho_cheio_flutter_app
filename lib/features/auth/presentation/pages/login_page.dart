import 'package:carrinho_cheio/core/navigator/app_navigator.dart';
import 'package:carrinho_cheio/core/utils/screen_size.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_event.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_state.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_status_enum.dart';
import 'package:carrinho_cheio/features/auth/presentation/pages/register_page.dart';
import 'package:carrinho_cheio/features/shopping_lists/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _onLoginPressed() {
    context.read<AuthBloc>().add(
      LoginEvent(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        //TODO MUDAR
      },
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final bool isLoading = state.status == AuthStatus.loading;

            return Container(
              child: AbsorbPointer(
                absorbing: isLoading,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 420,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.02),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'E-mail',

                                border: OutlineInputBorder(),
                              ),
                            ),

                            const SizedBox(
                              height: 16,
                            ),

                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Senha',
                                border: OutlineInputBorder(),
                              ),
                            ),

                            const SizedBox(
                              height: 24,
                            ),

                            ElevatedButton(
                              onPressed: isLoading ? null : _onLoginPressed,
                              child: isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(),
                                    )
                                  : const Text(
                                      'Entrar',
                                    ),
                            ),

                            TextButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      AppNavigator.push(RegisterPage());
                                    },
                              child: const Text(
                                'Criar conta',
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
      ),
    );
  }
}

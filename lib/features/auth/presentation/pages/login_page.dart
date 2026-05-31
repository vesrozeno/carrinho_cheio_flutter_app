import 'package:carrinho_cheio/core/navigator/app_navigator.dart';
import 'package:carrinho_cheio/core/widgets/custom_text_field.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_event.dart';
import 'package:carrinho_cheio/features/auth/presentation/pages/auth_page_base.dart';
import 'package:carrinho_cheio/features/auth/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_validators/form_validator.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    context.read<AuthBloc>().add(
      LoginEvent(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthPageBase(
      topText: 'Entre com sua conta:',
      buttonText: 'Entrar',
      bottomText: 'Ainda não tem conta?',
      bottomActionText: 'Criar',
      mainContext: Form(
        key: _formKey,
        child: Column(
          spacing: 15,
          children: [
            CustomTextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email_outlined,
              labelText: 'E-mail',
              inputFormatters: [LengthLimitingTextInputFormatter(20)],
              validator: (value) {
                return Validator.required(errorMessage: 'Insira seu e-mail')(value) ?? Validator.email(errorMessage: 'Insira um email válido')(value);
              },
            ),
            CustomTextField(
              controller: _passwordController,
              obscureText: true,
              labelText: 'Senha',
              prefixIcon: Icons.password_outlined,
              validator: (value) {
                return Validator.required(errorMessage: 'Insira sua senha')(value);
              },
            ),
          ],
        ),
      ),
      onButtonPressed: _onLoginPressed,
      onActionTextPressed: () {
        AppNavigator.pushAndRemoveUntil(RegisterPage());
      },
    );
  }
}

import 'package:carrinho_cheio/core/navigator/app_navigator.dart';
import 'package:carrinho_cheio/core/widgets/custom_text_field.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_event.dart';
import 'package:carrinho_cheio/features/auth/presentation/pages/auth_base_page.dart';
import 'package:carrinho_cheio/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_validators/form_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _onRegisterPressed() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    context.read<AuthBloc>().add(
      RegisterUserEvent(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthBasePage(
      topText: 'Cadastre sua conta:',
      buttonText: 'Cadastrar',
      bottomText: 'Já tem uma conta?',
      bottomActionText: 'Entrar',
      mainContext: Form(
        key: _formKey,
        child: Column(
          spacing: 15,
          children: [
            CustomTextField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              prefixIcon: Icons.account_circle,
              focusNode: _nameFocus,
              textInputAction: TextInputAction.next,
              nextFocusNode: _emailFocus,
              labelText: 'Nome',
              inputFormatters: [LengthLimitingTextInputFormatter(100)],
              validator: (value) {
                return Validator.required(errorMessage: 'Insira seu nome')(value);
              },
            ),
            CustomTextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email_outlined,
              focusNode: _emailFocus,
              textInputAction: TextInputAction.next,
              nextFocusNode: _passwordFocus,
              labelText: 'E-mail',
              inputFormatters: [LengthLimitingTextInputFormatter(254)],
              validator: (value) {
                return Validator.required(errorMessage: 'Insira seu e-mail')(value) ?? Validator.email(errorMessage: 'Insira um email válido')(value);
              },
            ),
            CustomTextField(
              controller: _passwordController,
              focusNode: _passwordFocus,
              textInputAction: TextInputAction.done,
              isPassword: true,
              labelText: 'Senha',
              prefixIcon: Icons.password_outlined,
              validator: (value) {
                return Validator.required(errorMessage: 'Insira sua senha')(value);
              },
              onFieldSubmitted: () {
                FocusScope.of(context).unfocus();
                _onRegisterPressed();
              },
            ),
          ],
        ),
      ),
      onButtonPressed: _onRegisterPressed,
      onActionTextPressed: () {
        AppNavigator.pushAndRemoveUntil(LoginPage());
      },
    );
  }
}

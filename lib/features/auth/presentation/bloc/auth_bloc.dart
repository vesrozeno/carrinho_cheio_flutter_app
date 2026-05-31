import 'package:carrinho_cheio/core/navigator/app_navigator.dart';
import 'package:carrinho_cheio/features/auth/domain/entities/user_entity.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_status_enum.dart';
import 'package:carrinho_cheio/features/auth/presentation/pages/login_page.dart';
import 'package:carrinho_cheio/features/shopping_lists/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this._authRepository,
  }) : super(AuthState.initial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterUserEvent>(_onRegisterUserEvent);
  }

  final AuthRepository _authRepository;

  Future<void> _onLoginEvent(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      const AuthState(
        status: AuthStatus.loading,
      ),
    );

    try {
      final UserEntity user = await _authRepository.login(
        email: event.email,
        password: event.password,
      );

      emit(
        AuthState(
          status: AuthStatus.authenticated,
          user: user,
        ),
      );
      if (AppNavigator.context.mounted) {
        ScaffoldMessenger.of(AppNavigator.context).showSnackBar(
          const SnackBar(
            content: Text(
              'Login realizado com sucesso',
            ),
          ),
        );
      }
      AppNavigator.pushAndRemoveUntil(HomePage());
    } catch (e) {
      emit(
        AuthState(
          status: AuthStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onRegisterUserEvent(
    RegisterUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      const AuthState(
        status: AuthStatus.loading,
      ),
    );

    try {
      final UserEntity user = await _authRepository.register(
        name: event.name,
        email: event.email,
        password: event.password,
      );

      emit(
        AuthState(
          status: AuthStatus.registered,
          user: user,
        ),
      );

      if (AppNavigator.context.mounted) {
        ScaffoldMessenger.of(AppNavigator.context).showSnackBar(
          const SnackBar(
            content: Text(
              'Cadastro realizado com sucesso',
            ),
          ),
        );
      }
      AppNavigator.pushAndRemoveUntil(LoginPage());
    } catch (e) {
      emit(
        AuthState(
          status: AuthStatus.error,
          message: e.toString(),
        ),
      );
    }
  }
}

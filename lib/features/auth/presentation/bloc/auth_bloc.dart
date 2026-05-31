import 'package:carrinho_cheio/features/auth/domain/entities/user_entity.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_status_enum.dart';
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

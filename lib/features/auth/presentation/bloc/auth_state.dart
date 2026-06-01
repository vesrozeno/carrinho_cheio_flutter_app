import 'package:carrinho_cheio/core/events/ui_event.dart';
import 'package:carrinho_cheio/features/auth/domain/entities/user_entity.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_status_enum.dart';

class AuthState {
  const AuthState({
    required this.status,
    this.user,
    this.uiEvent,
  });

  final AuthStatus status;
  final UserEntity? user;
  final UiEvent? uiEvent;

  bool get isAuthorized => user != null;

  factory AuthState.initial() {
    return const AuthState(
      status: AuthStatus.initial,
    );
  }

  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
    UiEvent? uiEvent,
    bool clearUiEvent = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      uiEvent: clearUiEvent ? null : (uiEvent ?? this.uiEvent),
    );
  }
}

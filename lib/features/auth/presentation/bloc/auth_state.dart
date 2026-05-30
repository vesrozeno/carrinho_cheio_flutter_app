import 'package:carrinho_cheio/features/auth/domain/entities/user_entity.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_status_enum.dart';

class AuthState {
  const AuthState({
    required this.status,
    this.user,
    this.message,
  });

  final AuthStatus status;
  final UserEntity? user;
  final String? message;

  bool get isAuthorized => user != null;

  factory AuthState.initial() {
    return const AuthState(
      status: AuthStatus.initial,
    );
  }
}

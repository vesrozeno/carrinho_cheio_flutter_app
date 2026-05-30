sealed class AuthEvent {}

class LoginRequested extends AuthEvent {
  LoginRequested({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class RegisterRequested extends AuthEvent {
  RegisterRequested({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;
}

class LogoutRequested extends AuthEvent {}

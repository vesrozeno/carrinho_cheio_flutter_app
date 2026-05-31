sealed class AuthEvent {}

class LoginEvent extends AuthEvent {
  LoginEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class RegisterUserEvent extends AuthEvent {
  RegisterUserEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;
}

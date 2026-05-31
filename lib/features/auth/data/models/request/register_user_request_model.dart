class RegisterUserEventRequestModel {
  const RegisterUserEventRequestModel({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;

  Map<String, dynamic> toJson() {
    return {
      'sdtUsuarios': {
        'UsuarioNome': name,
        'UsuarioEmail': email,
        'UsuarioSenha': password,
      },
    };
  }
}

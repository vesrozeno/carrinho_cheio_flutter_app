import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
  });

  factory UserModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserModel(
      id: json['UsuarioId'] as int? ?? 0,
      name: json['UsuarioNome'] as String? ?? '',
    );
  }
}

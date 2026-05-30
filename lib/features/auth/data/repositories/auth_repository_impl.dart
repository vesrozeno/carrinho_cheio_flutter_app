import 'package:carrinho_cheio/core/errors/app_exception.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this._datasource,
  });

  final AuthDatasource _datasource;

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final response = await _datasource.login(
      email: email,
      password: password,
    );

    if (!response.isSuccess) {
      throw AppException(response.message ?? 'Erro desconhecido');
    }

    return response.user;
  }

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _datasource.register(
      name: name,
      email: email,
      password: password,
    );

    if (!response.isSuccess) {
      throw AppException(response.message ?? 'Erro desconhecido');
    }

    return UserEntity(
      id: response.userId,
      name: name,
    );
  }
}

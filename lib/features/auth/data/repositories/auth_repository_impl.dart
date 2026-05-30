import 'package:carrinho_cheio/core/errors/app_exception.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_datasource.dart';
import '../../../../core/storage/session_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this._datasource,
    required this._sessionStorage,
  });

  final AuthDatasource _datasource;
  final SessionStorage _sessionStorage;

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

    await _sessionStorage.saveUser(
      userId: response.user.id,
      userName: response.user.name.isNotEmpty ? response.user.name : email,
    );

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

  @override
  Future<void> logout() {
    return _sessionStorage.clear();
  }

  @override
  Future<bool> isLoggedIn() async {
    return await _sessionStorage.getUserId() != null;
  }
}

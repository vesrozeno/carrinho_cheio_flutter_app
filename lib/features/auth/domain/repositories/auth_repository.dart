import 'package:carrinho_cheio/features/auth/data/models/response/register_user_response_model.dart';

import '../entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<UserEntity> login({
    required String email,
    required String password,
  });

  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  });

  Future<void> logout();
  Future<bool> isLoggedIn();
}

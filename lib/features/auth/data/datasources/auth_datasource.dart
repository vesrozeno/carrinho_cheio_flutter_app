import 'package:carrinho_cheio/features/auth/data/models/response/login_response_model.dart';
import 'package:carrinho_cheio/features/auth/data/models/response/register_user_response_model.dart';

abstract interface class AuthDatasource {
  Future<LoginResponseModel> login({required String email, required String password});
  Future<RegisterResponseModel> register({required String name, required String email, required String password});
}

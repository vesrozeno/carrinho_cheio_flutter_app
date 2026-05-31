import 'package:carrinho_cheio/features/auth/data/datasources/auth_datasource.dart';
import 'package:carrinho_cheio/features/auth/data/models/request/login_request_model.dart';
import 'package:carrinho_cheio/features/auth/data/models/request/register_user_request_model.dart';
import 'package:carrinho_cheio/features/auth/data/models/response/login_response_model.dart';
import 'package:carrinho_cheio/features/auth/data/models/response/register_user_response_model.dart';
import 'package:dio/dio.dart';

class AuthDatasourceImpl implements AuthDatasource {
  AuthDatasourceImpl({required this._apiClientDio});

  final Dio _apiClientDio;

  @override
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    final LoginRequestModel request = LoginRequestModel(
      email: email,
      password: password,
    );

    final response = await _apiClientDio.post(
      '/LogInUsuario',
      data: request.toJson(),
    );

    return LoginResponseModel.fromJson(response.data);
  }

  @override
  Future<RegisterResponseModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final RegisterUserEventRequestModel request = RegisterUserEventRequestModel(
      name: name,
      email: email,
      password: password,
    );

    final response = await _apiClientDio.post(
      '/InsertUsuario',
      data: request.toJson(),
    );

    return RegisterResponseModel.fromJson(response.data);
  }
}

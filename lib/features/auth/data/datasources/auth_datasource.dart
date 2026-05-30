import 'package:carrinho_cheio/features/auth/data/models/request/login_request_model.dart';
import 'package:carrinho_cheio/features/auth/data/models/request/register_user_request_model.dart';
import 'package:carrinho_cheio/features/auth/data/models/response/login_response_model.dart';
import 'package:carrinho_cheio/features/auth/data/models/response/register_user_response_model.dart';
import 'package:dio/dio.dart';

class AuthDatasource {
  AuthDatasource({required this._apiClientDio});

  final Dio _apiClientDio;

  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    final request = LoginRequestModel(
      email: email,
      password: password,
    );
    ;
    //TODO REMOVER PRINTS
    print(request.toJson());

    final response = await _apiClientDio.post(
      '/LogInUsuario',
      data: request.toJson(),
    );

    print(response.data);

    return LoginResponseModel.fromJson(response.data);
  }

  Future<RegisterResponseModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final request = RegisterUserRequestModel(
      name: name,
      email: email,
      password: password,
    );

    print(request.toJson());

    final response = await _apiClientDio.post(
      '/InsertUsuario',
      data: request.toJson(),
    );

    print(response.data);

    return RegisterResponseModel.fromJson(response.data);
  }
}

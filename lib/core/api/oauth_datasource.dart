import 'package:carrinho_cheio/core/config/app_config.dart';
import 'package:dio/dio.dart';

class OAuthDatasource {
  OAuthDatasource({required this._dio});

  final Dio _dio;

  Future<String> getToken() async {
    final response = await _dio.post(
      AppConfig.tokenUrl,
      data: {
        'client_id': AppConfig.clientId,
        'grant_type': 'password',
        'scope': AppConfig.scope,
        'username': AppConfig.username,
        'password': AppConfig.password,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    return response.data['access_token'];
  }
}

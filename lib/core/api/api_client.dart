import 'package:carrinho_cheio/core/api/interceptors/auth_interceptor.dart';
import 'package:dio/dio.dart';

import '../config/app_config.dart';

class ApiClient {
  ApiClient({required this._authInterceptor}) {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.apiUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    dio.interceptors.add(_authInterceptor);
  }

  late final Dio dio;
  final AuthInterceptor _authInterceptor;
}

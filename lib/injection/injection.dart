import 'package:carrinho_cheio/core/api/api_client.dart';
import 'package:carrinho_cheio/core/api/interceptors/auth_interceptor.dart';
import 'package:carrinho_cheio/core/api/oauth_datasource.dart';
import 'package:carrinho_cheio/core/storage/session_storage.dart';
import 'package:carrinho_cheio/core/storage/token_storage.dart';
import 'package:carrinho_cheio/features/auth/data/datasources/auth_datasource.dart';
import 'package:carrinho_cheio/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:carrinho_cheio/features/auth/domain/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerLazySingleton(FlutterSecureStorage.new);
  getIt.registerLazySingleton(() => TokenStorage(getIt()));
  getIt.registerLazySingleton(() => AuthInterceptor(getIt()));
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => OAuthDatasource(dio: getIt()));
  getIt.registerLazySingleton(() => ApiClient(authInterceptor: getIt()));
  getIt.registerLazySingleton(() => AuthDatasource(apiClientDio: getIt<ApiClient>().dio));
  getIt.registerLazySingleton(() => SessionStorage(storage: getIt()));
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(datasource: getIt(), sessionStorage: getIt()));
}

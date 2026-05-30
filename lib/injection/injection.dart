import 'package:carrinho_cheio/core/api/api_client.dart';
import 'package:carrinho_cheio/core/api/interceptors/auth_interceptor.dart';
import 'package:carrinho_cheio/core/api/interceptors/logging_interceptor.dart';
import 'package:carrinho_cheio/core/api/oauth_datasource.dart';
import 'package:carrinho_cheio/core/storage/token_storage.dart';
import 'package:carrinho_cheio/features/auth/data/datasources/auth_datasource.dart';
import 'package:carrinho_cheio/features/auth/data/datasources/auth_datasource_impl.dart';
import 'package:carrinho_cheio/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:carrinho_cheio/features/auth/domain/repositories/auth_repository.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:carrinho_cheio/features/shopping_lists/data/datasources/shopping_lists_datasource.dart';
import 'package:carrinho_cheio/features/shopping_lists/data/datasources/shopping_lists_datasource_impl.dart';
import 'package:carrinho_cheio/features/shopping_lists/data/repositories/shopping_lists.repository_impl.dart';
import 'package:carrinho_cheio/features/shopping_lists/domain/repositories/shopping_lists_repository.dart';
import 'package:carrinho_cheio/features/shopping_lists/presentation/bloc/shopping_lists.bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerLazySingleton(FlutterSecureStorage.new);
  getIt.registerLazySingleton(() => TokenStorage(storage: getIt()));
  getIt.registerLazySingleton(() => AuthInterceptor(tokenStorage: getIt()));
  getIt.registerLazySingleton(() => LoggingInterceptor());
  getIt.registerLazySingleton(() => ApiClient(authInterceptor: getIt<AuthInterceptor>(), loggingInterceptor: getIt<LoggingInterceptor>()));
  getIt.registerLazySingleton(() => OAuthDatasourceImpl(dio: getIt<ApiClient>().dio));
  getIt.registerLazySingleton<AuthDatasource>(() => AuthDatasourceImpl(apiClientDio: getIt<ApiClient>().dio));
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(datasource: getIt()));
  getIt.registerLazySingleton<AuthBloc>(() => AuthBloc(authRepository: getIt()));
  getIt.registerLazySingleton<ShoppingListsDatasource>(() => ShoppingListsDatasourceImpl(apiClientDio: getIt<ApiClient>().dio));
  getIt.registerLazySingleton<ShoppingListsRepository>(() => ShoppingListsRepositoryImpl(datasource: getIt()));
  getIt.registerLazySingleton<ShoppingListsBloc>(() => ShoppingListsBloc(repository: getIt(), authBloc: getIt()));
}

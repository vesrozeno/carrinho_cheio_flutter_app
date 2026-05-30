import '../../injection/injection.dart';
import '../api/oauth_datasource.dart';
import '../storage/token_storage.dart';

class AppBootstrap {
  static Future<void> initialize() async {
    final token = await getIt<OAuthDatasource>().getToken();

    await getIt<TokenStorage>().saveToken(token);
  }
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  TokenStorage(this._storage);

  final FlutterSecureStorage _storage;

  Future<void> saveToken(String token) {
    return _storage.write(key: 'api_token', value: token);
  }

  Future<String?> getToken() {
    return _storage.read(key: 'api_token');
  }
}

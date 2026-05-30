import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionStorage {
  SessionStorage({required this._storage});

  final FlutterSecureStorage _storage;

  static const String _userIdKey = 'user_id';
  static const String _userNameKey = 'user_name';

  Future<void> saveUser({
    required int userId,
    required String userName,
  }) async {
    await _storage.write(
      key: _userIdKey,
      value: userId.toString(),
    );

    await _storage.write(
      key: _userNameKey,
      value: userName,
    );
  }

  Future<int?> getUserId() async {
    final value = await _storage.read(
      key: _userIdKey,
    );

    return int.tryParse(value ?? '');
  }

  Future<String?> getUserName() async {
    return _storage.read(
      key: _userNameKey,
    );
  }

  Future<void> clear() async {
    await _storage.delete(key: _userIdKey);
    await _storage.delete(key: _userNameKey);
  }
}

import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppConfig {
  static String get apiUrl => dotenv.env['API_URL']!;
  static String get tokenUrl => dotenv.env['TOKEN_URL']!;
  static String get clientId => dotenv.env['CLIENT_ID']!;
  static String get username => dotenv.env['USERNAME']!;
  static String get password => dotenv.env['PASSWORD']!;
  static String get scope => dotenv.env['SCOPE']!;
}

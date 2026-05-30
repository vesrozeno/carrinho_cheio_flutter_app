import 'package:carrinho_cheio/features/auth/data/models/api_message_model.dart';

class RegisterResponseModel {
  const RegisterResponseModel({
    required this.messages,
    required this.userId,
    required this.userName,
  });

  final List<ApiMessageModel> messages;
  final int userId;
  final String userName;

  bool get isSuccess => userId > 0;

  String? get message {
    if (messages.isEmpty) {
      return null;
    }

    return messages.first.description;
  }

  factory RegisterResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return RegisterResponseModel(
      messages: (json['Messages'] as List<dynamic>? ?? [])
          .map(
            (e) => ApiMessageModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
      userId: json['UsuarioId'] as int? ?? 0,
      userName: json['UsuarioNome'] as String? ?? '',
    );
  }
}

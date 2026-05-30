import '../../../../../core/models/api_message_model.dart';
import '../user_model.dart';

class LoginResponseModel {
  const LoginResponseModel({
    required this.messages,
    required this.user,
  });

  final List<ApiMessageModel> messages;
  final UserModel user;

  bool get isSuccess => user.id > 0;

  String? get message {
    if (messages.isEmpty) {
      return null;
    }

    return messages.first.description;
  }

  factory LoginResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return LoginResponseModel(
      messages: (json['Messages'] as List<dynamic>? ?? [])
          .map(
            (e) => ApiMessageModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
      user: UserModel.fromJson(json),
    );
  }
}

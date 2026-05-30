class ApiMessageModel {
  const ApiMessageModel({
    required this.id,
    required this.type,
    required this.description,
  });

  final String id;
  final int type;
  final String description;

  bool get isSuccess => type == 2;

  bool get isError => type == 1;

  factory ApiMessageModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ApiMessageModel(
      id: json['Id'] ?? '',
      type: json['Type'] ?? 0,
      description: json['Description'] ?? '',
    );
  }
}

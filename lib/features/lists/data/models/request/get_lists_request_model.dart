class GetListsRequestModel {
  const GetListsRequestModel({
    required this.userId,
  });

  final int userId;

  Map<String, dynamic> toJson() {
    return {
      'Usuarioid': userId,
    };
  }
}

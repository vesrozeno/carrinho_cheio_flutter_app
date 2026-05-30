class CreateListRequestModel {
  const CreateListRequestModel({
    required this.userId,
    required this.listName,
  });

  final int userId;
  final String listName;

  Map<String, dynamic> toJson() {
    return {
      'sdtNovaLista': {
        'UsuarioId': userId,
        'ListaNome': listName,
      },
    };
  }
}

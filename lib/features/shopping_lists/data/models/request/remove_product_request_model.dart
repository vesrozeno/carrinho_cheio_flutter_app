class RemoveProductRequestModel {
  const RemoveProductRequestModel({
    required this.listId,
    required this.productName,
  });

  final int listId;
  final String productName;

  Map<String, dynamic> toJson() {
    return {
      'UsuarioListaId': listId,
      'UsuarioListaProdutosNome': productName,
    };
  }
}

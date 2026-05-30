class AddProductRequestModel {
  const AddProductRequestModel({
    required this.listId,
    required this.productName,
  });

  final int listId;
  final String productName;

  Map<String, dynamic> toJson() {
    return {
      'sdtNovoProdutoLista': {
        'UsuarioListaId': listId,
        'UsuarioListaProdutosNome': productName,
      },
    };
  }
}

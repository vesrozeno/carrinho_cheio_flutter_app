class AddProductRequestModel {
  const AddProductRequestModel({
    required this.listId,
    required this.productName,
    required this.categoryId,
  });

  final int listId;
  final String productName;
  final int categoryId;

  Map<String, dynamic> toJson() {
    return {
      'sdtNovoProdutoLista': {
        'UsuarioListaId': listId,
        'UsuarioListaProdutosNome': productName,
        "CategoriaProdutoId": categoryId,
      },
    };
  }
}

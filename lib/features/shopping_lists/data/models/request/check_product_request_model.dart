class CheckProductRequestModel {
  const CheckProductRequestModel({
    required this.listId,
    required this.productName,
    required this.isChecked,
  });

  final int listId;
  final String productName;
  final int isChecked;

  Map<String, dynamic> toJson() {
    return {
      'sdtReceberEstadoProdutoLista': {
        'UsuarioListaId': listId,
        'UsuarioListaProdutosNome': productName,
        'UsuarioListaProdutoCheck': isChecked,
      },
    };
  }
}

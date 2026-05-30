import '../../domain/entities/shopping_list_entity.dart';
import 'product_model.dart';

class ShoppingListModel extends ShoppingListEntity {
  const ShoppingListModel({
    required super.id,
    required super.current,
    required super.total,
    required super.title,
    required super.products,
  });

  factory ShoppingListModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ShoppingListModel(
      id: _parseInt(json['ListaId']),
      title: json['Titulo'] ?? '',
      current: _parseInt(json['atual']),
      total: _parseInt(json['total']),
      products: (json['produto'] as List<dynamic>? ?? [])
          .map(
            (product) => ProductModel.fromJson(
              product as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'ListaId': id,
      'Titulo': title,
      'produto': products
          .map(
            (product) => (product as ProductModel).toJson(),
          )
          .toList(),
    };
  }

  ShoppingListEntity toEntity() {
    return ShoppingListEntity(
      id: id,
      title: title,
      current: current,
      total: total,
      products: products,
    );
  }
}

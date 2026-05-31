import '../../domain/entities/list_entity.dart';
import 'product_model.dart';

class ListModel extends ListEntity {
  const ListModel({
    required super.id,
    required super.current,
    required super.total,
    required super.title,
    required super.products,
  });

  factory ListModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ListModel(
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

  ListEntity toEntity() {
    return ListEntity(
      id: id,
      title: title,
      current: current,
      total: total,
      products: products,
    );
  }
}

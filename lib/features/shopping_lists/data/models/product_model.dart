import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.name,
    required super.category,
    required super.isChecked,
  });

  factory ProductModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ProductModel(
      name: json['nome'] ?? '',
      category: json['categoria'] ?? '',
      isChecked: (json['check'] ?? 0) == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': name,
      'categoria': category,
      'check': isChecked ? 1 : 0,
    };
  }
}

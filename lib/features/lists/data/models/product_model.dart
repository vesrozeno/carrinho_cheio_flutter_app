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
      category: json['categoria'] ?? 1,
      isChecked: (json['check'] ?? 2) == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': name,
      'categoria': category,
      'check': isChecked ? 1 : 2,
    };
  }
}

import 'package:carrinho_cheio/features/lists/domain/entities/product_entity.dart';

class ListEntity {
  const ListEntity({
    required this.id,
    required this.current,
    required this.total,
    required this.title,
    required this.products,
  });

  final int id;
  final int current;
  final int total;
  final String title;
  final List<ProductEntity> products;

  ListEntity copyWith({
    int? id,
    int? current,
    int? total,
    String? title,
    List<ProductEntity>? products,
  }) {
    return ListEntity(
      id: id ?? this.id,
      current: current ?? this.current,
      total: total ?? this.total,
      title: title ?? this.title,
      products: products ?? this.products,
    );
  }
}

import 'package:carrinho_cheio/features/shopping_lists/domain/entities/product_entity.dart';

class ShoppingListEntity {
  const ShoppingListEntity({
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
}

class ProductEntity {
  const ProductEntity({
    required this.name,
    required this.category,
    required this.isChecked,
  });

  final String name;
  final String category;
  final bool isChecked;

  ProductEntity copyWith({
    String? name,
    String? category,
    bool? isChecked,
  }) {
    return ProductEntity(
      name: name ?? this.name,
      category: category ?? this.category,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}

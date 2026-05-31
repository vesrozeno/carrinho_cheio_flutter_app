class ProductEntity {
  const ProductEntity({
    required this.name,
    required this.category,
    required this.isChecked,
  });

  final String name;
  final String category;
  final bool isChecked;
}

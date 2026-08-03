class ShoppingItemModel {
  final String id;
  final String name;
  final String category;
  bool isBought;

  ShoppingItemModel({
    required this.id,
    required this.name,
    required this.category,
    this.isBought = false,
  });
}
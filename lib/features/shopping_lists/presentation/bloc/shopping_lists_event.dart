abstract class ShoppingListsEvent {}

class LoadShoppingListsRequested extends ShoppingListsEvent {
  LoadShoppingListsRequested();
}

class CreateShoppingList extends ShoppingListsEvent {
  final String name;

  CreateShoppingList({
    required this.name,
  });
}

class AddProduct extends ShoppingListsEvent {
  final int listId;
  final String productName;

  AddProduct({
    required this.listId,
    required this.productName,
  });
}

class RemoveProduct extends ShoppingListsEvent {
  final int listId;
  final String productName;

  RemoveProduct({
    required this.listId,
    required this.productName,
  });
}

class CheckProduct extends ShoppingListsEvent {
  final int listId;
  final String productName;
  final bool isChecked;

  CheckProduct({
    required this.listId,
    required this.productName,
    required this.isChecked,
  });
}

abstract class ListsEvent {}

class LoadListsEvent extends ListsEvent {
  LoadListsEvent();
}

class LoadCategoriesEvent extends ListsEvent {
  LoadCategoriesEvent();
}

class ClearUIEvent extends ListsEvent {
  ClearUIEvent();
}

class CreateListEvent extends ListsEvent {
  final String name;

  CreateListEvent({
    required this.name,
  });
}

class AddProductEvent extends ListsEvent {
  final int listId;
  final String productName;
  final int categoryId;

  AddProductEvent({
    required this.listId,
    required this.productName,
    required this.categoryId,
  });
}

class RemoveProductEvent extends ListsEvent {
  final int listId;
  final String productName;

  RemoveProductEvent({
    required this.listId,
    required this.productName,
  });
}

class CheckProductEvent extends ListsEvent {
  final int listId;
  final String productName;
  final bool isChecked;

  CheckProductEvent({
    required this.listId,
    required this.productName,
    required this.isChecked,
  });
}

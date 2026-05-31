abstract class ListsEvent {}

class LoadListsRequested extends ListsEvent {
  LoadListsRequested();
}

class CreateList extends ListsEvent {
  final String name;

  CreateList({
    required this.name,
  });
}

class AddProduct extends ListsEvent {
  final int listId;
  final String productName;

  AddProduct({
    required this.listId,
    required this.productName,
  });
}

class RemoveProduct extends ListsEvent {
  final int listId;
  final String productName;

  RemoveProduct({
    required this.listId,
    required this.productName,
  });
}

class CheckProduct extends ListsEvent {
  final int listId;
  final String productName;
  final bool isChecked;

  CheckProduct({
    required this.listId,
    required this.productName,
    required this.isChecked,
  });
}

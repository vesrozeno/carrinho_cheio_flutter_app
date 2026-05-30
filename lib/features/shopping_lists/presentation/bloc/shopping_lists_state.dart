import '../../domain/entities/shopping_list_entity.dart';
import 'shopping_lists_status_enum.dart';

class ShoppingListsState {
  const ShoppingListsState({
    required this.status,
    this.lists,
    this.message,
  });

  final ShoppingListsStatus status;
  final List<ShoppingListEntity>? lists;
  final String? message;

  factory ShoppingListsState.initial() {
    return const ShoppingListsState(
      status: ShoppingListsStatus.initial,
      lists: null,
      message: null,
    );
  }

  ShoppingListsState copyWith({
    ShoppingListsStatus? status,
    List<ShoppingListEntity>? lists,
    String? message,
  }) {
    return ShoppingListsState(
      status: status ?? this.status,
      lists: lists ?? this.lists,
      message: message ?? this.message,
    );
  }
}

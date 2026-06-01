import 'package:carrinho_cheio/core/events/ui_event.dart';
import 'package:carrinho_cheio/features/lists/domain/entities/category_entity.dart';
import '../../domain/entities/list_entity.dart';
import 'lists_status_enum.dart';

class ListsState {
  const ListsState({
    required this.status,
    this.lists,
    this.categories,
    this.uiEvent,
  });

  final ListsStatus status;
  final List<ListEntity>? lists;
  final List<CategoryEntity>? categories;
  final UiEvent? uiEvent;

  factory ListsState.initial() {
    return const ListsState(
      status: ListsStatus.initial,
      lists: null,
      categories: null,
      uiEvent: null,
    );
  }

  ListsState copyWith({
    ListsStatus? status,
    List<ListEntity>? lists,
    List<CategoryEntity>? categories,
    UiEvent? uiEvent,
    bool clearUiEvent = false,
  }) {
    return ListsState(
      status: status ?? this.status,
      lists: lists ?? this.lists,
      categories: categories ?? this.categories,
      uiEvent: clearUiEvent ? null : (uiEvent ?? this.uiEvent),
    );
  }
}

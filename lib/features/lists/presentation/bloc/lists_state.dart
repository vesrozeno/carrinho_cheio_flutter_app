import '../../domain/entities/list_entity.dart';
import 'lists_status_enum.dart';

class ListsState {
  const ListsState({
    required this.status,
    this.lists,
    this.message,
  });

  final ListsStatus status;
  final List<ListEntity>? lists;
  final String? message;

  factory ListsState.initial() {
    return const ListsState(
      status: ListsStatus.initial,
      lists: null,
      message: null,
    );
  }

  ListsState copyWith({
    ListsStatus? status,
    List<ListEntity>? lists,
    String? message,
  }) {
    return ListsState(
      status: status ?? this.status,
      lists: lists ?? this.lists,
      message: message ?? this.message,
    );
  }
}

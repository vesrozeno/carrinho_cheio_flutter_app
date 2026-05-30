import 'package:carrinho_cheio/core/models/api_message_model.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/shopping_lists_repository.dart';
import 'shopping_lists_state.dart';
import 'shopping_lists_status_enum.dart';
import 'shopping_lists_event.dart';

class ShoppingListsBloc extends Bloc<ShoppingListsEvent, ShoppingListsState> {
  final ShoppingListsRepository _repository;
  final AuthBloc _authBloc;

  ShoppingListsBloc({required this._repository, required this._authBloc}) : super(ShoppingListsState.initial()) {
    on<LoadShoppingListsRequested>(_onLoadLists);
    on<CreateShoppingList>(_onCreateList);
    on<AddProduct>(_onAddProduct);
    on<RemoveProduct>(_onRemoveProduct);
    on<CheckProduct>(_onCheckProduct);
  }

  Future<void> _onLoadLists(
    LoadShoppingListsRequested event,
    Emitter<ShoppingListsState> emit,
  ) async {
    emit(state.copyWith(status: ShoppingListsStatus.loading));

    try {
      if (!_authBloc.state.isAuthorized) {
        emit(
          state.copyWith(
            status: ShoppingListsStatus.error,
            message: 'Usuário não está logado',
          ),
        );
        return;
      }

      final result = await _repository.getUserLists(userId: _authBloc.state.user!.id);

      emit(
        state.copyWith(
          status: ShoppingListsStatus.success,
          lists: result,
          message: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ShoppingListsStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onCreateList(
    CreateShoppingList event,
    Emitter<ShoppingListsState> emit,
  ) async {
    emit(state.copyWith(status: ShoppingListsStatus.loading));

    try {
      if (!_authBloc.state.isAuthorized) {
        emit(
          state.copyWith(
            status: ShoppingListsStatus.error,
            message: 'Usuário não está logado',
          ),
        );
        return;
      }
      final ApiMessageModel response = await _repository.createList(
        userId: _authBloc.state.user!.id,
        listName: event.name,
      );

      if (response.isError) {
        emit(
          state.copyWith(
            status: ShoppingListsStatus.error,
            message: response.description,
          ),
        );
      }

      add(LoadShoppingListsRequested());
    } catch (e) {
      emit(
        state.copyWith(
          status: ShoppingListsStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onAddProduct(
    AddProduct event,
    Emitter<ShoppingListsState> emit,
  ) async {
    emit(state.copyWith(status: ShoppingListsStatus.loading));

    try {
      final ApiMessageModel response = await _repository.addProduct(
        listId: event.listId,
        productName: event.productName,
      );

      if (response.isError) {
        emit(
          state.copyWith(
            status: ShoppingListsStatus.error,
            message: response.description,
          ),
        );
      }
      add(LoadShoppingListsRequested());
    } catch (e) {
      emit(
        state.copyWith(
          status: ShoppingListsStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onRemoveProduct(
    RemoveProduct event,
    Emitter<ShoppingListsState> emit,
  ) async {
    emit(state.copyWith(status: ShoppingListsStatus.loading));

    try {
      final ApiMessageModel response = await _repository.removeProduct(
        listId: event.listId,
        productName: event.productName,
      );

      if (response.isError) {
        emit(
          state.copyWith(
            status: ShoppingListsStatus.error,
            message: response.description,
          ),
        );
      }
      add(LoadShoppingListsRequested());
    } catch (e) {
      emit(
        state.copyWith(
          status: ShoppingListsStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onCheckProduct(
    CheckProduct event,
    Emitter<ShoppingListsState> emit,
  ) async {
    emit(state.copyWith(status: ShoppingListsStatus.loading));

    try {
      final ApiMessageModel response = await _repository.checkProduct(listId: event.listId, productName: event.productName, isChecked: event.isChecked);

      if (response.isError) {
        emit(
          state.copyWith(
            status: ShoppingListsStatus.error,
            message: response.description,
          ),
        );
      }
      add(LoadShoppingListsRequested());
    } catch (e) {
      emit(
        state.copyWith(
          status: ShoppingListsStatus.error,
          message: e.toString(),
        ),
      );
    }
  }
}

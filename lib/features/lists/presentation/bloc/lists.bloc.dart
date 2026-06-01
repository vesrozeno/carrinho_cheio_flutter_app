import 'package:carrinho_cheio/core/events/ui_event.dart';
import 'package:carrinho_cheio/core/models/api_message_model.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:carrinho_cheio/features/lists/domain/entities/list_entity.dart';
import 'package:carrinho_cheio/features/lists/domain/entities/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/lists_repository.dart';
import 'lists_state.dart';
import 'lists_status_enum.dart';
import 'lists_event.dart';

class ListsBloc extends Bloc<ListsEvent, ListsState> {
  final ListsRepository _repository;
  final AuthBloc _authBloc;

  ListsBloc({required this._repository, required this._authBloc}) : super(ListsState.initial()) {
    on<LoadListsEvent>(_onLoadLists);
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<CreateListEvent>(_onCreateList);
    on<AddProductEvent>(_onAddProduct);
    on<RemoveProductEvent>(_onRemoveProduct);
    on<CheckProductEvent>(_onCheckProduct);
    on<ClearUIEvent>(_onClearUI);

    add(LoadCategoriesEvent());
  }

  Future<void> _onLoadLists(
    LoadListsEvent event,
    Emitter<ListsState> emit,
  ) async {
    emit(state.copyWith(status: ListsStatus.loadingLists));

    try {
      if (!_authBloc.state.isAuthorized) {
        emit(
          state.copyWith(
            status: ListsStatus.error,
            uiEvent: UiEvent(
              type: UiEventType.error,
              message: 'Usuário não está logado',
            ),
          ),
        );
        return;
      }

      final result = await _repository.getUserLists(userId: _authBloc.state.user!.id);

      emit(
        state.copyWith(
          status: ListsStatus.loaded,
          lists: result,
          uiEvent: UiEvent(
            type: UiEventType.success,
            message: 'Listas carregadas',
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ListsStatus.error,
          uiEvent: UiEvent(
            type: UiEventType.error,
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onLoadCategories(
    LoadCategoriesEvent event,
    Emitter<ListsState> emit,
  ) async {
    try {
      final categories = await _repository.getCategories();

      emit(
        state.copyWith(
          status: ListsStatus.loaded,
          categories: categories,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ListsStatus.error,
          uiEvent: UiEvent(
            type: UiEventType.error,
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onClearUI(
    ClearUIEvent event,
    Emitter<ListsState> emit,
  ) async {
    emit(
      state.copyWith(
        clearUiEvent: true,
        uiEvent: null,
      ),
    );
  }

  Future<void> _silentReloadLists(Emitter<ListsState> emit) async {
    try {
      if (!_authBloc.state.isAuthorized) {
        emit(
          state.copyWith(
            status: ListsStatus.error,
            uiEvent: UiEvent(
              type: UiEventType.error,
              message: 'Usuário não está logado',
            ),
          ),
        );
        return;
      }
      final lists = await _repository.getUserLists(
        userId: _authBloc.state.user!.id,
      );

      emit(
        state.copyWith(
          lists: lists,
        ),
      );

      return;
    } catch (e) {
      emit(
        state.copyWith(
          status: ListsStatus.error,
          uiEvent: UiEvent(
            type: UiEventType.error,
            message: e.toString(),
          ),
        ),
      );
      return;
    }
  }

  Future<void> _onCreateList(
    CreateListEvent event,
    Emitter<ListsState> emit,
  ) async {
    try {
      if (!_authBloc.state.isAuthorized) {
        emit(
          state.copyWith(
            status: ListsStatus.error,
            uiEvent: UiEvent(
              type: UiEventType.error,
              message: 'Usuário não está logado',
            ),
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
            status: ListsStatus.error,
            uiEvent: UiEvent(
              type: UiEventType.error,
              message: response.description,
            ),
          ),
        );
      }
      final createdList = ListEntity(id: 0, current: 0, total: 0, title: event.name, products: []);

      emit(
        state.copyWith(
          status: ListsStatus.success,
          lists: [...?state.lists, createdList],
          uiEvent: UiEvent(
            type: UiEventType.success,
            message: 'Nova lista criada',
          ),
        ),
      );

      await _silentReloadLists(emit);
    } catch (e) {
      emit(
        state.copyWith(
          status: ListsStatus.error,
          uiEvent: UiEvent(
            type: UiEventType.error,
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onAddProduct(
    AddProductEvent event,
    Emitter<ListsState> emit,
  ) async {
    try {
      final ApiMessageModel response = await _repository.addProduct(
        listId: event.listId,
        productName: event.productName,
        categoryId: event.categoryId,
      );

      if (response.isError) {
        emit(
          state.copyWith(
            status: ListsStatus.error,
            uiEvent: UiEvent(
              type: UiEventType.error,
              message: response.description,
            ),
          ),
        );
      }

      final List<ListEntity>? updatedLists = state.lists?.map((list) {
        if (list.id != event.listId) return list;
        final String? categoryName = state.categories
            ?.firstWhere(
              (c) => c.id == event.categoryId,
            )
            .name;
        final List<ProductEntity> updatedProducts = [
          ...list.products,
          ProductEntity(
            name: event.productName,
            category: categoryName ?? 'Sem categoria',
            isChecked: false,
          ),
        ];
        return list.copyWith(products: updatedProducts);
      }).toList();

      emit(
        state.copyWith(
          status: ListsStatus.success,
          lists: updatedLists,
          uiEvent: UiEvent(
            type: UiEventType.success,
            message: 'Produto adicionado',
          ),
        ),
      );

      await _silentReloadLists(emit);
    } catch (e) {
      emit(
        state.copyWith(
          status: ListsStatus.error,
          uiEvent: UiEvent(
            type: UiEventType.error,
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onRemoveProduct(
    RemoveProductEvent event,
    Emitter<ListsState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: ListsStatus.loadingProductChange,
        ),
      );
      final ApiMessageModel response = await _repository.removeProduct(
        listId: event.listId,
        productName: event.productName,
      );

      if (response.isError) {
        emit(
          state.copyWith(
            status: ListsStatus.error,
            uiEvent: UiEvent(
              type: UiEventType.error,
              message: response.description,
            ),
          ),
        );
      }
      final List<ListEntity>? updatedLists = state.lists?.map((list) {
        if (list.id != event.listId) return list;
        final List<ProductEntity> updatedProducts = list.products.where((product) => product.name != event.productName).toList();
        return list.copyWith(
          products: updatedProducts,
        );
      }).toList();

      emit(
        state.copyWith(
          lists: updatedLists,
          status: ListsStatus.success,
          uiEvent: UiEvent(
            type: UiEventType.success,
            message: 'Produto removido',
          ),
        ),
      );

      await _silentReloadLists(emit);
    } catch (e) {
      emit(
        state.copyWith(
          status: ListsStatus.error,
          uiEvent: UiEvent(
            type: UiEventType.error,
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onCheckProduct(
    CheckProductEvent event,
    Emitter<ListsState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: ListsStatus.loadingProductChange,
        ),
      );

      final ApiMessageModel response = await _repository.checkProduct(listId: event.listId, productName: event.productName, isChecked: event.isChecked);

      if (response.isError) {
        emit(
          state.copyWith(
            status: ListsStatus.error,
            uiEvent: UiEvent(
              type: UiEventType.error,
              message: response.description,
            ),
          ),
        );
      }

      final List<ListEntity> updatedLists = state.lists!.map((list) {
        if (list.id != event.listId) return list;

        final List<ProductEntity> updatedProducts = list.products.map((p) {
          if (p.name == event.productName) {
            return p.copyWith(isChecked: event.isChecked);
          }
          return p;
        }).toList();

        return list.copyWith(products: updatedProducts);
      }).toList();

      emit(
        state.copyWith(
          status: ListsStatus.success,
          lists: updatedLists,
        ),
      );

      await _silentReloadLists(emit);
    } catch (e) {
      emit(
        state.copyWith(
          status: ListsStatus.error,
          uiEvent: UiEvent(
            type: UiEventType.error,
            message: e.toString(),
          ),
        ),
      );
    }
  }
}

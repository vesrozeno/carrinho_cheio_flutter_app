import 'package:carrinho_cheio/core/models/api_message_model.dart';

import '../../domain/entities/shopping_list_entity.dart';
import '../../domain/repositories/shopping_lists_repository.dart';
import '../datasources/shopping_lists_datasource.dart';
import '../models/shopping_list_model.dart';

class ShoppingListsRepositoryImpl implements ShoppingListsRepository {
  final ShoppingListsDatasource _datasource;

  ShoppingListsRepositoryImpl({required this._datasource});

  @override
  Future<List<ShoppingListEntity>> getUserLists({required int userId}) async {
    final List<ShoppingListModel> result = await _datasource.getUserLists(userId: userId);

    return result.map((e) => e.toEntity()).toList();
  }

  @override
  Future<ApiMessageModel> createList({
    required int userId,
    required String listName,
  }) {
    return _datasource.createList(
      userId: userId,
      listName: listName,
    );
  }

  @override
  Future<ApiMessageModel> addProduct({
    required int listId,
    required String productName,
  }) {
    return _datasource.addProduct(
      listId: listId,
      productName: productName,
    );
  }

  @override
  Future<ApiMessageModel> removeProduct({
    required int listId,
    required String productName,
  }) {
    return _datasource.removeProduct(
      listId: listId,
      productName: productName,
    );
  }

  @override
  Future<ApiMessageModel> checkProduct({required int listId, required String productName, required bool isChecked}) {
    return _datasource.checkProduct(
      listId: listId,
      productName: productName,
      isChecked: isChecked,
    );
  }
}

import 'package:carrinho_cheio/core/models/api_message_model.dart';

import '../entities/shopping_list_entity.dart';

abstract class ShoppingListsRepository {
  Future<List<ShoppingListEntity>> getUserLists({required int userId});
  Future<ApiMessageModel> createList({required int userId, required String listName});
  Future<ApiMessageModel> addProduct({required int listId, required String productName});
  Future<ApiMessageModel> removeProduct({required int listId, required String productName});
  Future<ApiMessageModel> checkProduct({required int listId, required String productName, required bool isChecked});
}

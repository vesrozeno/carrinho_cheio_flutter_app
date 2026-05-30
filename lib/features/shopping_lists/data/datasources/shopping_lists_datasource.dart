import 'package:carrinho_cheio/core/models/api_message_model.dart';

import '../models/shopping_list_model.dart';

abstract interface class ShoppingListsDatasource {
  Future<List<ShoppingListModel>> getUserLists({required int userId});
  Future<ApiMessageModel> createList({required int userId, required String listName});
  Future<ApiMessageModel> addProduct({required int listId, required String productName});
  Future<ApiMessageModel> removeProduct({required int listId, required String productName});
  Future<ApiMessageModel> checkProduct({required int listId, required String productName, required bool isChecked});
}

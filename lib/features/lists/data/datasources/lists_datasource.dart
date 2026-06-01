import 'package:carrinho_cheio/core/models/api_message_model.dart';
import 'package:carrinho_cheio/features/lists/data/models/category_model.dart';

import '../models/list_model.dart';

abstract interface class ListsDatasource {
  Future<List<ListModel>> getUserLists({required int userId});
  Future<ApiMessageModel> createList({required int userId, required String listName});
  Future<ApiMessageModel> addProduct({required int listId, required String productName, required int categoryId});
  Future<ApiMessageModel> removeProduct({required int listId, required String productName});
  Future<ApiMessageModel> checkProduct({required int listId, required String productName, required bool isChecked});
  Future<List<CategoryModel>> getCategories();
}

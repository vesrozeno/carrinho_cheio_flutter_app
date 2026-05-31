import 'package:carrinho_cheio/core/models/api_message_model.dart';

import '../../domain/entities/list_entity.dart';
import '../../domain/repositories/lists_repository.dart';
import '../datasources/lists_datasource.dart';
import '../models/list_model.dart';

class ListsRepositoryImpl implements ListsRepository {
  final ListsDatasource _datasource;

  ListsRepositoryImpl({required this._datasource});

  @override
  Future<List<ListEntity>> getUserLists({required int userId}) async {
    final List<ListModel> result = await _datasource.getUserLists(userId: userId);

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

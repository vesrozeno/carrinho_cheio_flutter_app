import 'package:carrinho_cheio/core/models/api_message_model.dart';
import 'package:carrinho_cheio/features/lists/data/datasources/lists_datasource.dart';
import 'package:carrinho_cheio/features/lists/data/models/request/add_product_request_model.dart';
import 'package:carrinho_cheio/features/lists/data/models/request/check_product_request_model.dart';
import 'package:carrinho_cheio/features/lists/data/models/request/create_list_request_model.dart';
import 'package:carrinho_cheio/features/lists/data/models/request/get_lists_request_model.dart';
import 'package:carrinho_cheio/features/lists/data/models/request/remove_product_request_model.dart';

import '../models/list_model.dart';
import 'package:dio/dio.dart';

class ListsDatasourceImpl implements ListsDatasource {
  final Dio _apiClientDio;

  ListsDatasourceImpl({required this._apiClientDio});

  @override
  Future<List<ListModel>> getUserLists({required int userId}) async {
    final request = GetListsRequestModel(userId: userId);
    final response = await _apiClientDio.get(
      '/Listasusuario',
      queryParameters: request.toJson(),
    );

    final List data = response.data['sdtListasUsuario'] ?? [];

    return data.map((json) => ListModel.fromJson(json)).toList();
  }

  @override
  Future<ApiMessageModel> createList({
    required int userId,
    required String listName,
  }) async {
    final CreateListRequestModel request = CreateListRequestModel(userId: userId, listName: listName);

    final response = await _apiClientDio.post(
      '/NovaLista',
      data: request.toJson(),
    );

    final List data = response.data['Messages'];

    return ApiMessageModel.fromJson(data.first);
  }

  @override
  Future<ApiMessageModel> addProduct({
    required int listId,
    required String productName,
  }) async {
    final AddProductRequestModel request = AddProductRequestModel(listId: listId, productName: productName);

    final response = await _apiClientDio.post(
      '/AdicionaProdutoLista',
      data: request.toJson(),
    );

    final List data = response.data['Messages'];

    return ApiMessageModel.fromJson(data.first);
  }

  @override
  Future<ApiMessageModel> removeProduct({
    required int listId,
    required String productName,
  }) async {
    final RemoveProductRequestModel request = RemoveProductRequestModel(
      listId: listId,
      productName: productName,
    );

    final response = await _apiClientDio.post(
      '/RemoveProdutoLista',
      data: request.toJson(),
    );

    final List data = response.data['Messages'];

    return ApiMessageModel.fromJson(data.first);
  }

  @override
  Future<ApiMessageModel> checkProduct({required int listId, required String productName, required bool isChecked}) async {
    final CheckProductRequestModel request = CheckProductRequestModel(
      listId: listId,
      productName: productName,
      isChecked: isChecked ? 1 : 2,
    );

    final response = await _apiClientDio.post(
      '/AlterarEstadoProduto',
      data: request.toJson(),
    );

    final List data = response.data['Messages'];

    return ApiMessageModel.fromJson(data.first);
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/app/core/data/remote/dto/product_data_model.dart';

final class ProductService {
  final Dio dio;
  final String _apiUrl =
      "https://ecommerce-flutter-app-a730d-default-rtdb.firebaseio.com";

  ProductService({required this.dio});

  Future<List<ProductDataModel>> getAll() async {
    final List<ProductDataModel> products = [];
    try {
      final Response response = await dio.get("$_apiUrl/products.json");
      if (response.data != null) {
        response.data.forEach((key, value) {
          debugPrint("forrrrr : $value ${key}");
          products.add(ProductDataModel.fromJson(key, value));
        });
      }
    } catch (e) {
      debugPrint("petttttttoooo $e");
      throw Exception(e);
    }
    debugPrint('vaaaaaaa $products');
    return products;
  }

  Future<bool> delete(String id) async {
    try {
      await dio.delete("$_apiUrl/products/$id.json");
    } catch (e) {
      throw (Exception("Error deleting product"));
    }
    return true;
  }

  Future<bool> add(ProductDataModel productDataModel) async {
    try {
      dio.post("$_apiUrl/products.json", data: productDataModel.toJson());
    } catch (e) {
      throw (Exception(e));
    }
    return true;
  }

  Future<bool> update(ProductDataModel productDataModel) async {
    try {
      await dio.patch("$_apiUrl/products/${productDataModel.id}.json",
          data: productDataModel.toJson());
    } catch (e) {
      throw (Exception(e));
    }
    return true;
  }
}

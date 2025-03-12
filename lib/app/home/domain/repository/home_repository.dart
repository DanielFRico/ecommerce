import 'package:ecommerce/app/core/domain/entity/product_entity.dart';

abstract class HomeRepository {
  Future<List<ProductEntity>> getProducts();
  Future<bool> deleteProduct(String id);
}

import 'package:ecommerce/app/core/domain/entity/product_entity.dart';

abstract class FormProductRepository {
  Future<bool> addProduct(ProductEntity productEntity);
  Future<bool> updateProduct(ProductEntity data);
}

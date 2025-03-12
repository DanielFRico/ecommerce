import 'package:ecommerce/app/home/domain/repository/home_repository.dart';
import 'package:ecommerce/app/home/presentation/model/product_model.dart';

class GetProductsUseCase {
  final HomeRepository homeRepository;
  GetProductsUseCase({required this.homeRepository});
  Future<List<ProductModel>> invoke() async {
    final List<ProductModel> products = [];
    final result = await homeRepository.getProducts();
    for (var product in result) {
      products.add(product.toProductModel());
    }
    return products;
  }
}

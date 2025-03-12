import 'package:ecommerce/app/home/domain/repository/home_repository.dart';

class DeleteProductsUseCase {
  final HomeRepository homeRepository;
  DeleteProductsUseCase({required this.homeRepository});
  Future<bool> invoke(String id) {
    return homeRepository.deleteProduct(id);
  }
}

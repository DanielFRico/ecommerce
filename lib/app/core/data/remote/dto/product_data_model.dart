import 'package:ecommerce/app/core/domain/entity/product_entity.dart';

class ProductDataModel {
  final String id;
  late String name;
  late String price;
  late String imageUrl;

  ProductDataModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl});

  ProductDataModel.fromJson(String this.id, Map<String, dynamic> json) {
    name = json["name"];
    price = json["price"].toString();
    imageUrl = json["image"];
  }

  ProductEntity toEntity() {
    return ProductEntity(
        id: id, name: name, imageUrl: imageUrl, price: int.parse(price));
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{"name": name, "price": price, "image": imageUrl};
  }
}

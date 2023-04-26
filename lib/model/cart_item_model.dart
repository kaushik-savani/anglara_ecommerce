import 'package:anglara_ecommerce/model/product_model.dart';

class CartItemModel {
  final ProductModel product;
  int quantity;

  CartItemModel(this.product, {this.quantity = 1});

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
}
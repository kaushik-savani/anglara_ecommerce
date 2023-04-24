import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/product_model.dart';

class CartRepository {
  Future<void> addToCart(ProductModel product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartItems = prefs.getStringList('cartItems');

    if (cartItems == null) {
      cartItems = [];
    }

    cartItems.add(json.encode(product.toJson()));

    await prefs.setStringList('cartItems', cartItems);
  }

  Future<List<ProductModel>> getCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartItems = prefs.getStringList('cartItems');

    if (cartItems == null) {
      return [];
    }

    return cartItems.map((item) => ProductModel.fromJson(json.decode(item))).toList();
  }

  Future<void> removeFromCart(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartItems = prefs.getStringList('cartItems');

    if (cartItems == null) {
      cartItems = [];
    }

    cartItems.removeAt(index);

    await prefs.setStringList('cartItems', cartItems);
  }

}

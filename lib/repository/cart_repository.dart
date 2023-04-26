import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/cart_item_model.dart';
import '../model/product_model.dart';


class CartRepository {
  Future<void> addToCart(ProductModel product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartItems = prefs.getStringList('cartItems');

    if (cartItems == null) {
      cartItems = [];
    }

    // Check if the product already exists in the cart
    int existingIndex = cartItems.indexWhere((item) {
      CartItemModel cartItem = CartItemModel.fromJson(json.decode(item));
      return cartItem.product.id == product.id;
    });

    if (existingIndex != -1) {
      // If product already exists, update its quantity
      CartItemModel cartItem = CartItemModel.fromJson(json.decode(cartItems[existingIndex]));
      cartItem.quantity += 1;
      cartItems[existingIndex] = json.encode(cartItem.toJson());
    } else {
      // If product doesn't exist, add it to the cart with quantity 1
      CartItemModel cartItem = CartItemModel(product);
      cartItems.add(json.encode(cartItem.toJson()));
    }

    await prefs.setStringList('cartItems', cartItems);
  }


  Future<List<CartItemModel>> getCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartItems = prefs.getStringList('cartItems');

    if (cartItems == null) {
      return [];
    }

    return cartItems.map((item) => CartItemModel.fromJson(json.decode(item))).toList();
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

  Future<void> updateCartItem(ProductModel product, int quantity) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartItems = prefs.getStringList('cartItems');

    if (cartItems == null) {
      return;
    }

    // Find the cart item with the given product id
    int existingIndex = cartItems.indexWhere((item) {
      CartItemModel cartItem = CartItemModel.fromJson(json.decode(item));
      return cartItem.product.id == product.id;
    });

    if (existingIndex != -1) {
      // If product already exists, update its quantity
      CartItemModel cartItem = CartItemModel.fromJson(json.decode(cartItems[existingIndex]));
      cartItem.quantity = quantity;
      cartItems[existingIndex] = json.encode(cartItem.toJson());
    }

    await prefs.setStringList('cartItems', cartItems);
  }
}

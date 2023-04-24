import 'dart:async';
import 'dart:convert';

import '../model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  final _productController = StreamController<List<ProductModel>>();

  Stream<List<ProductModel>> get productsStream => _productController.stream;

  void getProducts(String category) async {
    var url = Uri.parse('https://fakestoreapi.com/products/category/$category');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      _productController.sink
          .add(result.map((e) => ProductModel.fromJson(e)).toList());
    } else {
      throw Exception("Failed to Load Data");
    }
  }

  void dispose() {
    _productController.close();
  }
}

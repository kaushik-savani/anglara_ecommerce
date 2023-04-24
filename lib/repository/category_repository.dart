import 'dart:convert';

import 'package:http/http.dart' as http;

class CategoryRepository{
  Future<List> FetchAllCategory() async {
    var url = Uri.parse('https://fakestoreapi.com/products/categories');
    var response = await http.get(url);
    if(response.statusCode==200){
      final List result=jsonDecode(response.body);
      return result;
    }else{
      throw Exception("Failed to Load Data");
    }
  }
}
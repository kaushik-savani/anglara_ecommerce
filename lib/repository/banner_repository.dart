import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/banner_model.dart';

class BannerRepository{
  Future<List<BannerModel>> getBanner() async {
    var url = Uri.parse('https://picsum.photos/v2/list?page=2&limit=5');
    var response = await http.get(url);
    if(response.statusCode==200){
      final List result=jsonDecode(response.body);
      return result.map((e) => BannerModel.fromJson(e)).toList();
    }else{
      throw Exception("Failed to Load Data");
    }
  }
}
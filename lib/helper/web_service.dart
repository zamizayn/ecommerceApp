import 'dart:convert';

import 'package:ecommerce/helper/productmodel.dart';
import 'package:http/http.dart' as http;

class WebService {
  final String BASE_URL = "https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad";

  Future<List<ProductsModel>> get() async {
     List<ProductsModel> list = [];
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(BASE_URL));
      responseJson = response;
      final body = jsonDecode(response.body);
     

      body.forEach((e) {
        list.add(ProductsModel.fromJson(e));
      });
      print("SUCCESSS" + list[0].tableMenuList.length.toString());

      // ProductsModel model = ProductsModel.fromJson(jsondata[0]);

    } catch (e) {
      print(e);
    }
    return list;
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'modals.dart';

class Api {
  Api._();
  static final Api api = Api._();
  List<Product> allProducts = [];

  String uri = 'https://dummyjson.com/products';
  Future<List<Product>> init() async {
    http.Response response = await http.get(
      Uri.parse(uri),
    );
    Logger().i(response.statusCode);
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      List list = data['products'];
      allProducts = list
          .map(
            (e) => Product.fromJson(json: e),
          )
          .toList();
    }
    return allProducts;
  }

  Future<List<Product>> delete(int id) async {
    http.Response response = await http.delete(
      Uri.parse('$uri/$id'),
    );

    return allProducts;
  }

  Future<List<Product>> upDate(String title) async {
    http.Response response = await http.put(
      Uri.parse(uri),
      body: jsonEncode(
        <String, String>{'title': title},
      ),
    );
    return allProducts;
  }
}

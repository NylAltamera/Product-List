import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static Future<List<Product>> fetchProducts(int skip) async {
    final url = Uri.parse(
      'https://dummyjson.com/products?limit=15&skip=$skip&select=title,price,thumbnail,brand,description'
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Product> products = (data['products'] as List)
          .map((item) => Product.fromJson(item))
          .toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../models/product.dart';

final productServiceProvider = Provider((ref) => ProductService());

class ProductService {
  Future<List<Product>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      List<Product> products =
          List.from(body).map((e) => Product.fromJson(e)).toList();
      return products;
    }
    throw Exception('Request Failed');
  }
}

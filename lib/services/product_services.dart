import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchProductList() async {
  final response = await http.get(
    Uri.parse('https://dummyjson.com/products'),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load products');
  }
}

Future<Map<String, dynamic>> fetchProductDetailService(String id) async {
  final response = await http.get(
    Uri.parse('https://dummyjson.com/products/$id'),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load product detail');
  }
}

Future<Map<String, dynamic>> fetchProductByCategory(String category) async {
  final response = await http.get(
    Uri.parse('https://dummyjson.com/products/category/$category'),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load product detail');
  }
}

Future<String> fetchCategoryList() async {
  final response = await http.get(
    Uri.parse('https://dummyjson.com/products/category-list'),
  );

  if (response.statusCode == 200) {
    // print(response.body);
    return response.body;
  } else {
    throw Exception('Failed to load product detail');
  }
}

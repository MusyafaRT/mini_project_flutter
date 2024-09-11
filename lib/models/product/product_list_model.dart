// To parse this JSON data, do
//
//     final productList = productListFromJson(jsonString);

import 'dart:convert';
import 'product_model.dart';

ProductList productListFromJson(String str) =>
    ProductList.fromJson(json.decode(str));

String productListToJson(ProductList data) => json.encode(data.toJson());

class ProductList {
  List<Product>? products;
  int? total;
  int? skip;
  int? limit;

  ProductList({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  ProductList copyWith({
    List<Product>? products,
    int? total,
    int? skip,
    int? limit,
  }) =>
      ProductList(
        products: products ?? this.products,
        total: total ?? this.total,
        skip: skip ?? this.skip,
        limit: limit ?? this.limit,
      );

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}

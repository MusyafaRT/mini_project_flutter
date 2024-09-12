import 'dart:convert';

import 'package:get/get.dart';
import 'package:mini_project/models/product/category_product_model.dart';
import 'package:mini_project/models/product/product_list_model.dart';
import 'package:mini_project/services/product_services.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var productList = <Product>[].obs;
  var categoryList = <String>[].obs;
  RxString selectedCategory = ''.obs;
  var productDetail = Product(
    id: 0,
    title: "",
    description: "",
    category: "",
    price: 0.0,
    discountPercentage: 0.0,
    rating: 0.0,
    stock: 0,
    tags: [],
    sku: "",
    weight: 0,
    dimensions: Dimensions(width: 0.0, height: 0.0, depth: 0.0),
    warrantyInformation: "",
    shippingInformation: "",
    availabilityStatus: "",
    reviews: [],
    returnPolicy: "",
    minimumOrderQuantity: 0,
    meta: Meta(
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      barcode: "example-barcode",
      qrCode: "example-qr-code",
    ),
    images: [],
    thumbnail: "",
  ).obs;

  @override
  void onInit() {
    fetchProducts();
    fetchCategories();
    super.onInit();
  }

  void filterProductByCategory(String category) {
    selectCategory(category);
    fetchProductListByCategory(category);
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void selectProductDetail(String id) {
    fetchProductDetail(id);
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    try {
      final response = await fetchProductList();
      ProductResponse productResponse = ProductResponse.fromJson(response);
      productList.assignAll(productResponse.products!);
    } catch (e) {
      throw Exception('Failed to load products');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCategories() async {
    isLoading.value = true;
    try {
      final response = await fetchCategoryList();
      CategoryResponse categoryResponse =
          CategoryResponse.fromJson(jsonDecode(response));
      categoryList.assignAll(categoryResponse.categories);
    } catch (e) {
      throw Exception('Failed to load categories');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProductListByCategory(String category) async {
    isLoading.value = true;
    try {
      final response = await fetchProductByCategory(category);
      ProductResponse productResponse = ProductResponse.fromJson(response);
      productList.assignAll(productResponse.products!);
    } catch (e) {
      throw Exception('Failed to load products');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProductDetail(String id) async {
    isLoading.value = true;
    try {
      final response = await fetchProductDetailService(id);
      Product product = Product.fromJson(response);
      productDetail.value = product;
      // print(productDetail);
    } catch (e) {
      throw Exception('Failed to load product detail');
    } finally {
      isLoading.value = false;
    }
  }
}

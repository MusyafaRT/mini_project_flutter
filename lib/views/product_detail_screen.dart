import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_project/controller/product_controller.dart';

class ProductDetail extends StatefulWidget {
  final int id;
  const ProductDetail({super.key, required this.id});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  void initState() {
    ProductController controller = Get.put(ProductController());
    controller.fetchProductDetail(widget.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductController controller = Get.put(ProductController());

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final product = controller.productDetail.value;

        if (product.id == 0) {
          return const Center(child: Text('Product not found.'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product.thumbnail!,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              Text(
                product.title!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                product.description!,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Text('Price: \$${product.price.toString()}'),
              // Add more product details as needed...
            ],
          ),
        );
      }),
    );
  }
}

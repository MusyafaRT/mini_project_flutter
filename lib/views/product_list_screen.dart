import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:mini_project/controller/product_controller.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var imageUrl = "https://image.tmdb.org/t/p/original";

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    ProductController controller = Get.put(ProductController());
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/pattern2.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Product List",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 500,
                    child: TextField(
                      controller: controller.searchController,
                      onChanged: (value) {
                        controller.searchProduct(value);
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search Product',
                        hintStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(154, 249, 182, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(
                      () => DropdownButton<String>(
                        menuMaxHeight: 200,
                        dropdownColor: const Color.fromRGBO(154, 249, 182, 1),
                        hint: const Text(
                          'Select Category',
                          style: TextStyle(color: Colors.black),
                        ),
                        value: controller.selectedCategory.value == ''
                            ? null
                            : controller.selectedCategory.value,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 0,
                          color: Colors.transparent,
                        ),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            controller.filterProductByCategory(newValue);
                          }
                        },
                        items: controller.categoryList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return Obx(
                    () {
                      if (controller.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: (screenWidth > 1200)
                              ? 6
                              : (screenWidth > 800)
                                  ? 3
                                  : 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75, // Adjust based on card size
                        ),
                        itemCount: controller.productList.length,
                        itemBuilder: (context, index) {
                          final product = controller.productList[index];
                          return GestureDetector(
                            onTap: () {
                              controller
                                  .selectProductDetail(product.id!.toString());
                              Get.toNamed("/product-detail/${product.id}");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                                  child: Card(
                                    elevation: 4.0,
                                    color: Colors.black.withOpacity(0.2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.network(
                                            '${product.thumbnail}',
                                            height: 150,
                                            width: 150,
                                            fit: BoxFit.cover,
                                            alignment: Alignment.center,
                                            frameBuilder: (context,
                                                    child,
                                                    frame,
                                                    wasSynchronouslyLoaded) =>
                                                frame == null
                                                    ? const Center(
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    16.0),
                                                            child:
                                                                CircularProgressIndicator()),
                                                      )
                                                    : child,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    children: [
                                                      RatingBar.builder(
                                                        initialRating:
                                                            product.rating!,
                                                        minRating: 1,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        unratedColor: Colors
                                                            .amber
                                                            .withAlpha(50),
                                                        itemCount: 5,
                                                        itemSize: 15.0,
                                                        itemPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    1.0),
                                                        itemBuilder:
                                                            (context, _) =>
                                                                const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                        onRatingUpdate:
                                                            (value) => {},
                                                        ignoreGestures: true,
                                                        glow: false,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        '(${product.rating.toString()})',
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    '${product.title}',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 180,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          '\$${product.price}',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${product.discountPercentage!.round()}% OFF',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

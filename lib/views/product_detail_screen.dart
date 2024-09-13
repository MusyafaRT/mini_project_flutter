import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:mini_project/controller/product_controller.dart';
import 'package:mini_project/models/product/product_list_model.dart';

@immutable
class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with TickerProviderStateMixin {
  late String id;

  @override
  void initState() {
    id = Get.parameters['id']!;
    ProductController controller = Get.put(ProductController());
    controller.fetchProductDetail(id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductController controller = Get.put(ProductController());
    TabController tabController = TabController(length: 3, vsync: this);
    final screen = MediaQuery.of(context).size;
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                    options: CarouselOptions(height: 500),
                    items: product.images!
                        .map((image) => Image.network(image,
                            frameBuilder: (context, child, frame,
                                    wasSynchronouslyLoaded) =>
                                frame == null
                                    ? const Center(
                                        child: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: CircularProgressIndicator()),
                                      )
                                    : child,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              }
                            }))
                        .toList()),
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    width: screen.width * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            RatingBar.builder(
                              initialRating: product.rating!,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              unratedColor: Colors.amber.withAlpha(50),
                              itemCount: 5,
                              itemSize: 30.0,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (value) => {},
                              ignoreGestures: true,
                              glow: false,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              '(${product.rating.toString()})',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          product.title!,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextWithValue(
                            label: "Availability: ",
                            value: product.availabilityStatus),
                        const SizedBox(height: 16),
                        TextWithValue(label: "SKU: ", value: product.sku),
                        const SizedBox(height: 16),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100],
                              ),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: TabBar(
                                  labelColor: Colors.black,
                                  unselectedLabelColor: Colors.grey[500],
                                  indicatorColor: Colors.black,
                                  dividerColor: Colors.transparent,
                                  controller: tabController,
                                  tabs: const [
                                    Tab(
                                      text: 'Description',
                                    ),
                                    Tab(
                                      text: 'Shipping Information',
                                    ),
                                    Tab(
                                      text: 'Reviews',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100],
                              ),
                              padding: const EdgeInsets.all(16),
                              height: screen.height * 0.3,
                              child: TabBarView(
                                controller: tabController,
                                children: [
                                  Tab1(product: product),
                                  Tab2(product: product),
                                  Tab3(product: product),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class TextWithValue extends StatelessWidget {
  const TextWithValue({
    super.key,
    // required this.product,
    required this.label,
    required this.value,
  });

  // final Product product;
  final String label;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label, // Label
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold, // Bold for the label
              color: Colors.black, // Add color if necessary
            ),
          ),
          TextSpan(
            text: value, // Data
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal, // Regular weight for the data
              color: Colors.black, // Add color if necessary
            ),
          ),
        ],
      ),
    );
  }
}

class Tab3 extends StatelessWidget {
  const Tab3({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 16,
              ),
              TextWithValue(
                  label: "Average Rating: ", value: product.rating.toString()),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: product.reviews!.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 4.0,
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.reviews![index].reviewerName!,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        product.reviews![index].comment!,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Rating: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              RatingBar.builder(
                                initialRating:
                                    product.reviews![index].rating!.toDouble(),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                unratedColor: Colors.amber.withAlpha(50),
                                itemCount: 5,
                                itemSize: 15.0,
                                // itemPadding:
                                //     const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (value) => {},
                                ignoreGestures: true,
                                glow: false,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          TextWithValue(
                              label: "Email: ",
                              value: product.reviews![index].reviewerEmail!),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Tab2 extends StatelessWidget {
  const Tab2({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWithValue(label: "Weight: ", value: "${product.weight} kg"),
              const SizedBox(
                width: 16,
              ),
              TextWithValue(
                  label: "Dimensions: ",
                  value:
                      "${product.dimensions!.width} x ${product.dimensions!.height} x ${product.dimensions!.depth} cm"),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWithValue(
                  label: "Warranty Information: ",
                  value: product.warrantyInformation),
              const SizedBox(
                width: 16,
              ),
              TextWithValue(
                  label: "Shipping Information: ",
                  value: product.shippingInformation),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWithValue(
                  label: "Return policy: ", value: product.returnPolicy),
              const SizedBox(
                width: 16,
              ),
              TextWithValue(
                  label: "Minimum Order Quantity: ",
                  value: product.minimumOrderQuantity.toString()),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}

class Tab1 extends StatelessWidget {
  const Tab1({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            product.description!,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 16,
          ),
          TextWithValue(label: "Stock: ", value: product.stock.toString()),
          const SizedBox(
            height: 10,
          ),
          TextWithValue(label: "Price: ", value: product.price.toString()),
          const SizedBox(
            height: 10,
          ),
          TextWithValue(
              label: "Discount: ", value: product.discountPercentage.toString())
        ],
      ),
    );
  }
}

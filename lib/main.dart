import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_project/views/product_detail_screen.dart';
import 'package:mini_project/views/product_list_screen.dart';
import 'package:mini_project/views/user_login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: [
        GetPage(name: '/product-list', page: () => const ProductScreen()),
        GetPage(name: '/product-detail/:id', page: () => const ProductDetail()),
      ],
      home: const UserLogin(),
    );
  }
}

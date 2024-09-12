import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_project/models/user_model.dart';
import 'package:mini_project/services/user_login_services.dart';
import 'package:mini_project/views/product_list_screen.dart';

class UserLoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false.obs;
  var loginResponse = Rxn<LoginResponse>();
  RxBool isVisible = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void onLogin() async {
    isLoading.value = true;
    try {
      final response =
          await userLogin(emailController.text, passwordController.text);
      loginResponse.value = LoginResponse.fromJson(response);

      if (response['message'] == 'Login successful') {
        Get.to(const ProductScreen());
        Get.snackbar("Success", "Login successful",
            backgroundColor: Colors.white, colorText: Colors.black);
      } else {
        Get.snackbar("Error: Login Failed", "Wrong email or password",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Login failed",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}

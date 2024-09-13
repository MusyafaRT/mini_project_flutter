import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_project/models/user_model.dart';
import 'package:mini_project/services/user_login_services.dart';

class UserLoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false.obs;
  var loginResponse = Rxn<LoginResponse>();
  RxBool isVisible = false.obs;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onLogin() async {
    isLoading.value = true;
    try {
      final response =
          await userLogin(emailController.text, passwordController.text);
      loginResponse.value = LoginResponse.fromJson(response);

      if (response['message'] == 'Login successful') {
        Get.toNamed("/product-list");
        Get.snackbar("Success", "Login successful",
            backgroundColor: Colors.white,
            colorText: Colors.black,
            duration: const Duration(seconds: 2));
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

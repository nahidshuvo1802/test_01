import 'package:flutter/material.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_core/src/get_main.dart' as SharePrefsHelper;
import 'package:get_x/get_instance/get_instance.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_navigation/src/snackbar/snackbar.dart';
import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_01/controllers/home_controller.dart';
import 'package:task_01/service/api_url.dart';
import '../service/api_client.dart';
import '../core/app_routes.dart';

class LoginController extends GetxController {
  // টেক্সট ফিল্ড কন্ট্রোলারসমূহ
  final usernameController = TextEditingController();
  final emailController = TextEditingController(); // শুধু রেজিস্ট্রেশনের জন্য
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  // --- লগইন মেথড ---
  Future<void> login() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        snackPosition: SnackPosition.bottom,
      );
      return;
    }

    try {
      isLoading(true);
      var body = {
        "username": usernameController.text.trim(),
        "password": passwordController.text.trim(),
      };

      var response = await ApiClient.postData(ApiUrl.login, body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Get.put(HomeController());
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.snackbar(
          "Login Failed",
          "Invalid credentials",
          snackPosition: SnackPosition.bottom,
        );
      }
    } finally {
      isLoading(false);
    }
  }

  // --- অ্যাকাউন্ট তৈরি (Register) মেথড ---
  Future<void> createAccount() async {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "All fields are required for registration",
        snackPosition: SnackPosition.bottom,
      );
      return;
    }

    try {
      isLoading(true);
      var body = {
        "username": usernameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };

      // FakeStore API User Creation Endpoint
      var response = await ApiClient.postData("/users", body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          "Success",
          "Account created successfully!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed(AppRoutes.initial);
      } else {
        Get.snackbar(
          "Error",
          "Failed to create account",
          snackPosition: SnackPosition.bottom,
        );
      }
    } finally {
      isLoading(false);
    }
  }
}

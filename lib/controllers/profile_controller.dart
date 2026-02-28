import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';
import '../models/user_model.dart'; // নিশ্চিত করো তোমার মডেলের পাথ ঠিক আছে
import '../service/api_client.dart';

class ProfileController extends GetxController {
  // userData কে এখন UserModel টাইপ হিসেবে ডিফাইন করা হয়েছে
  var userData = UserModel().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  void fetchUserProfile() async {
    try {
      isLoading(true);

      // নতুন এন্ডপয়েন্ট: https://fakestoreapi.com/users/10
      // ApiClient.getData ব্যবহার করে ডাটা ফেচ করা হচ্ছে
      var response = await ApiClient.getData("/users/10");

      if (response.statusCode == 200) {
        // API থেকে আসা Map ডাটাকে UserModel-এ কনভার্ট করা হচ্ছে
        userData.value = UserModel.fromJson(response.body);
      } else {
        Get.snackbar("Error", "Failed to load profile data");
      }
    } catch (e) {
      Get.snackbar("Error", "An unexpected error occurred: $e");
    } finally {
      isLoading(false);
    }
  }
}

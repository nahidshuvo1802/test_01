import 'package:flutter/material.dart';
import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';
import '../models/product_model.dart';
import '../service/api_client.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController; // TabController ডিফাইন করা হলো
  var productList = <ProductModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // ৩টি ট্যাবের জন্য কন্ট্রোলার ইনিশিয়ালাইজ করা হলো
    tabController = TabController(length: 3, vsync: this);
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      var response = await ApiClient.getData("/products");
      if (response.statusCode == 200) {
        List body = response.body;
        productList.assignAll(body.map((e) => ProductModel.fromJson(e)).toList());
      }
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    tabController.dispose(); // মেমোরি লিক রোধে ডিসপোজ করা হলো
    super.onClose();
  }
}
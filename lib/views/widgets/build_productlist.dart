import 'package:flutter/material.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_instance/src/extension_instance.dart';
import 'package:get_x/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:task_01/controllers/home_controller.dart';

Widget buildProductList(String category) {
  final HomeController controller = Get.find<HomeController>();

  return Builder(
    builder: (context) {
      return CustomScrollView(
        // স্লাইভার ইনজেক্টর যা অ্যাপ-বারের নিচে জায়গা তৈরি করবে
        slivers: [
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final products = category == "all"
                ? controller.productList
                : controller.productList
                      .where((p) => p.category == category)
                      .toList();

            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final product = products[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: ListTile(
                    leading: Image.network(
                      product.image ?? '',
                      width: 50,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image),
                    ),
                    title: Text(
                      product.title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      "\$${product.price}",
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        Text(product.rating?.rate.toString() ?? '0.0'),
                      ],
                    ),
                  ),
                );
              }, childCount: products.length),
            );
          }),
        ],
      );
    },
  );
}

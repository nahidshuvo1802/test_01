import 'package:flutter/material.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_instance/src/extension_instance.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_state_manager/src/simple/get_view.dart';
import '../core/app_const.dart';
import '../core/app_routes.dart';
import '../views/widgets/build_productlist.dart';
import '../views/widgets/search_bar_widget.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // কন্ট্রোলার চেক করা, যদি না থাকে তবে পুট করা
    final controller = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController());

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              pinned: true,
              expandedHeight: 280.0,
              backgroundColor: Colors.orange,
              elevation: 0,
              actions: [
                IconButton(
                  icon: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.orange),
                  ),
                  onPressed: () => Get.toNamed(AppRoutes.profile),
                ),
                const SizedBox(width: 10),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(AppConstants.banner, fit: BoxFit.cover),
                    Container(color: Colors.black26),
                    const Positioned(
                      bottom: 70,
                      left: 15,
                      right: 15,
                      child: SearchBarWidget(),
                    ),
                  ],
                ),
              ),
              bottom: TabBar(
                controller: controller.tabController,
                indicatorColor: Colors.white,
                indicatorWeight: 3,
                tabs: const [
                  Tab(text: "All"),
                  Tab(text: "Electronics"),
                  Tab(text: "Jewelery"),
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: controller.tabController,
          children: [
            "all",
            "electronics",
            "jewelery",
          ].map((cat) => buildProductList(cat)).toList(),
        ),
      ),
    );
  }
}

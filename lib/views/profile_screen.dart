import 'package:flutter/material.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_instance/src/extension_instance.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_x/get_state_manager/src/simple/get_view.dart';
import '../controllers/profile_controller.dart';
import '../models/user_model.dart';

ProfileController controller = Get.put(ProfileController());

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // userData এখন UserModel টাইপ হিসেবে ব্যবহার হবে
        UserModel user = controller.userData.value;
        String fullName =
            "${user.name?.firstname ?? ''} ${user.name?.lastname ?? ''}".trim();

        return SingleChildScrollView(
          child: Column(
            children: [
              // হেডার সেকশন
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person, size: 50),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      fullName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.email ?? '',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),

              // ইউজার ইনফরমেশন লিস্ট
              ListTile(
                leading: const Icon(Icons.phone),
                title: const Text("Phone"),
                subtitle: Text(user.phone ?? 'N/A'),
              ),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text("Address"),
                subtitle: Text(
                  "${user.address?.number}, ${user.address?.street}, ${user.address?.city}",
                ),
              ),
              ListTile(
                leading: const Icon(Icons.pin_drop),
                title: const Text("Zip Code"),
                subtitle: Text(user.address?.zipcode ?? 'N/A'),
              ),

              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () => Get.offAllNamed('/'),
              ),
            ],
          ),
        );
      }),
    );
  }
}

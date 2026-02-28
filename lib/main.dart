import 'package:flutter/material.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_instance/src/extension_instance.dart';
import 'package:get_x/get_navigation/src/root/get_material_app.dart';
import 'package:get_x/get_navigation/src/routes/transitions_type.dart';
import 'core/app_routes.dart';
import 'service/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Storage Helper ইনজেক্ট করা যেন অ্যাপের শুরুতে এটি রেডি থাকে
  Get.put(SharePrefsHelper());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Daraz Style App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
      defaultTransition: Transition.cupertino,
    );
  }
}
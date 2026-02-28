import 'package:get_x/get_navigation/src/routes/get_route.dart';
import 'package:task_01/views/create_account_page.dart';
import 'package:task_01/views/home_screen.dart';
import 'package:task_01/views/login_page.dart';
import 'package:task_01/views/profile_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String register = '/register';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const LoginScreen()),
    GetPage(name: '/register', page: () => RegisterScreen()),

    //Main Login Page
    GetPage(
      name: home,
      page: () => const HomeScreen(), // Main Listing / products Page
    ),
    GetPage(
      name: profile,
      page: () => const ProfileScreen(), // ইউজার প্রোফাইল পেজ
    ),
  ];
}

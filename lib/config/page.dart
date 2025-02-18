import 'package:get/get.dart';
import 'package:my_chat/contact/contact.dart';
import 'package:my_chat/pages/auth/auth.dart';
import 'package:my_chat/pages/home/home.dart';
import 'package:my_chat/profile/profile.dart';

var pagePath = [
  GetPage(
    name: "/authScreen",
    page: () => const AuthScreen(),
  ),
  GetPage(name: "/homeScreen", page: () => const HomeScreen()),
  GetPage(name: "/profileScreen", page: () => const ProfileScreen()),
  GetPage(name: "/contactScreen", page: () => const ContactScreen()),
];

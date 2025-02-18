import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final auth = FirebaseAuth.instance;

  void onInit() async {
    super.onInit();
    await splashHandel();
  }

  Future<void> splashHandel() async {
    Future.delayed(
      Duration(seconds: 2),
    );

    if (await auth.currentUser != null) {
      await Get.offAllNamed("/homeScreen");
    } else {
      Get.offAllNamed("/authScreen");
    }
  }
}

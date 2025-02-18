import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_chat/model/user.dart';

class DBController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  RxList<UserModel> userList = <UserModel>[].obs;
  RxBool isLoading = false.obs;

  void onInit() async {
    super.onInit();
    await getUserList();
  }

  Future<void> getUserList() async {
    try {
      isLoading.value = true;
      await db.collection("users").get().then((val) {
        userList.value =
            val.docs.map((e) => UserModel.fromJson(e.data())).toList();
      });
    } catch (e) {}
  }
}

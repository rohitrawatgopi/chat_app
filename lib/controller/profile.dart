import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_chat/controller/cloudinary.dart';
import 'package:my_chat/model/user.dart';

class ProfileController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  Rx isLoading = false.obs;

  Rx<UserModel> currentUser = UserModel().obs;

  void onInit() async {
    super.onInit();
    await getUserDetails();
  }

  Future<void> getUserDetails() async {
    await db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .get()
        .then((val) => {currentUser.value = UserModel.fromJson(val.data()!)});
    print(currentUser.value.email.toString());
  }

  Future<void> updateProfile(
      String name, String imageUrl, String about, String phoneNumber) async {
    isLoading.value = true;

    String? imgSrc = await uploadImageToCloudinary(imageUrl);
    imgSrc == null
        ? imgSrc = currentUser.value.userProfileUrl
        : imgSrc = imgSrc;

    print(imgSrc);
    print(currentUser.value.userProfileUrl);
    final updatedUser = UserModel(
        email: auth.currentUser!.email,
        id: auth.currentUser!.uid,
        name: name,
        about: about,
        userProfileUrl: imgSrc,
        phoneNumber: phoneNumber);

    await db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .set(updatedUser.toJson());

    print(imgSrc);
  }
}

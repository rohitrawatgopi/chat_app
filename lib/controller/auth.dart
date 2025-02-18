import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_chat/model/user.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

// For Login
  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      print("Login successful");

      Get.offAllNamed("/homeScreen");
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("User not found. Please sign up.");
      } else if (e.code == "wrong-password") {
        print("Incorrect password. Try again.");
      } else if (e.code == "invalid-email") {
        print("Invalid email format.");
      } else {
        print("FirebaseAuthException: ${e.code}");
      }
    } catch (e) {
      print("Error: $e");
    }
    isLoading.value = false;
  }

  Future<void> createUser(String email, String password, String name) async {
    try {
      isLoading.value = true;
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await initUser(email, name);
      print("User created successfully");
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        print("Password is too weak.");
      } else if (e.code == "email-already-in-use") {
        print("This email is already registered.");
      } else {
        print("FirebaseAuthException: ${e.code}");
      }
    } catch (e) {
      print("Error: $e");
    }
    isLoading.value = false;
  }

  Future<void> logOutUser() async {
    await auth.signOut();
    Get.offAllNamed("/authScreen");
  }

  Future<void> initUser(String email, String name) async {
    try {
      var newUser = UserModel(
          email: email,
          name: name,
          id: auth.currentUser!.uid,
          userProfileUrl: auth.currentUser!.photoURL);

      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .set(newUser.toJson());
    } catch (e) {
      print(e.toString());
    }
  }
}

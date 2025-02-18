import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusController extends GetxController with WidgetsBindingObserver {
  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    await db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .update({"status": "online"});
  }

  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  @override
  void didchangeAppLifecycleState(AppLifecycleState state) async {
    print("ApplicationState");
    if (state == AppLifecycleState.inactive) {
      print("offline");

      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .update({"status": "offline"});
    } else if (state == AppLifecycleState.resumed) {
      print("online");

      await db
          .collection("user")
          .doc(auth.currentUser!.uid)
          .update({"status": "online"});
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}

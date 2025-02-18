import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:my_chat/model/chat_room.dart';
import 'package:my_chat/model/user.dart';

class ContactController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  RxList<UserModel> userList = <UserModel>[].obs;
  RxBool isLoading = false.obs;
  RxList<ChatRoomModel> chatRoomList = <ChatRoomModel>[].obs;
  void onInit() async {
    super.onInit();
    await getUserList();
    await getChatRoomList();
  }

  Future<void> getUserList() async {
    userList.value.clear();

    try {
      isLoading.value = true;
      await db.collection("users").get().then((val) {
        userList.value =
            val.docs.map((e) => UserModel.fromJson(e.data())).toList();
      });
    } catch (e) {}
  }

  Future<List<ChatRoomModel>> getChatRoomList() async {
    List<ChatRoomModel> tempChatroomList = [];
    await db
        .collection("chats")
        .orderBy("timeStamp", descending: true)
        .get()
        .then((value) {
      tempChatroomList =
          value.docs.map((e) => ChatRoomModel.fromJson(e.data())).toList();
    });

    chatRoomList.value = tempChatroomList
        .where((e) => e.id!.contains(auth.currentUser!.uid))
        .toList();

    return chatRoomList;
  }

  Future<void> saveContact(UserModel user) async {
    try {
      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("contacts")
          .doc(user.id)
          .set(user.toJson());
    } catch (e) {
      if (kDebugMode) {
        log("while saving contact");
      }

      log(e.toString());
    }
  }

  Stream<List<UserModel>> getContacts() {
    return db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("contacts")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => UserModel.fromJson(doc.data()),
            )
            .toList());
  }
}

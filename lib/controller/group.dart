import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_chat/config/custom_message.dart';
import 'package:my_chat/controller/cloudinary.dart';
import 'package:my_chat/model/chat.dart';
import 'package:my_chat/model/group.dart';
import 'package:my_chat/model/user.dart';
import 'package:my_chat/pages/home/home.dart';
import 'package:my_chat/profile/profile.dart';
import 'package:uuid/uuid.dart';

class GroupController extends GetxController {
  RxList<UserModel> groupMember = <UserModel>[].obs;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  final auth = FirebaseAuth.instance;
  RxList<GroupModel> groupList = <GroupModel>[].obs;
  RxString selectedImagePath = "".obs;

  @override
  void onInit() {
    super.onInit();
    getGroup();
  }

  final uuid = Uuid();
  String? imageUrl;
  void selectMembers(UserModel user) {
    if (groupMember.contains(user)) {
      groupMember.remove(user);
    } else {
      groupMember.add(user);
    }
  }

  Future<void> createGroup(String groupName, String imagePath) async {
    try {
      String groupId = uuid.v6();
      isLoading.value = true;

      groupMember.add(UserModel(
          id: auth.currentUser!.uid,
          name: profileController.currentUser.value.name,
          userProfileUrl: profileController.currentUser.value.userProfileUrl,
          email: profileController.currentUser.value.email,
          role: "admin"));

      if (imagePath != "") {
        imageUrl = await uploadImageToCloudinary(imagePath);
      }

      var newGroup = GroupModel(
          id: groupId,
          name: groupName,
          profileUrl: imageUrl,
          members: groupMember..toList(),
          timeStamp: DateTime.now().toString(),
          createdAt: DateTime.now().toString(),
          createdBy: auth.currentUser!.uid);

      await db.collection("groups").doc(groupId).set(newGroup.toJson());

      successMessage("Group created");
      isLoading.value = false;
      Get.offAll(HomeScreen());
    } catch (e) {
      isLoading.value = false;

      log(e.toString());
    }
  }

  Future<void> getGroup() async {
    try {
      isLoading.value = true;

      List<GroupModel> tempList = [];

      await db.collection("groups").get().then((e) {
        tempList = e.docs.map((e) => GroupModel.fromJson(e.data())).toList();
      });

      groupList.clear();
      groupList.value = tempList
          .where((e) =>
              e.members!.any((element) => element.id == auth.currentUser!.uid))
          .toList();
      isLoading.value = false;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> sendGroupMessage(
      String groupId, String imagePath, String message) async {
    isLoading.value = true;
    log(imagePath.toString());
    if (imagePath != "") {
      imageUrl = await uploadImageToCloudinary(selectedImagePath.value);
    }
    var chatId = uuid.v6();
    log(imagePath);
    var newChat = ChatModel(
        id: chatId,
        message: message,
        senderId: auth.currentUser!.uid,
        imageUrl: imageUrl,
        timestamp: DateTime.now().toString(),
        senderName: profileController.currentUser.value.name);

    try {
      await db
          .collection("groups")
          .doc(groupId)
          .collection("messages")
          .doc(chatId)
          .set(newChat.toJson());
      isLoading.value = false;
    } catch (e) {
      log(e.toString());
      isLoading.value = false;
    }
    selectedImagePath.value = "";
  }

  Stream<List<ChatModel>> groupMessages(String groupId) {
    return db
        .collection("groups")
        .doc(groupId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatModel.fromJson(doc.data()))
            .toList());
  }

  Future<void> addMemberTOGroup(String groupId, UserModel user) async {
    isLoading.value = true;

    await db.collection("groups").doc(groupId).update({
      "members": FieldValue.arrayUnion([user.toJson()])
    });
    getGroup();
    isLoading.value = false;
  }
}

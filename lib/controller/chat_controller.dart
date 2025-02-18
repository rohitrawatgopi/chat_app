import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_chat/controller/cloudinary.dart';
import 'package:my_chat/controller/contact.dart';
import 'package:my_chat/controller/profile.dart';
import 'package:my_chat/model/call.dart';
import 'package:my_chat/model/chat.dart';
import 'package:my_chat/model/chat_room.dart';
import 'package:my_chat/model/user.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  ProfileController profileController = Get.put(ProfileController());

  ContactController contactController = Get.put(ContactController());
  RxString selectedImagePath = "".obs;

  var imageUrl = Rxn<String>(); // Allows null values

  var uuid = Uuid();

  String getRoomId(String targetId) {
    String currentUserId = auth.currentUser!.uid;
    return (currentUserId.compareTo(targetId) > 0)
        ? currentUserId + targetId
        : targetId + currentUserId;
  }

  UserModel getSender(UserModel currentUser, UserModel targetUser) {
    String currentUserId = currentUser.id!;

    String targetUserId = targetUser.id!;

    return (currentUserId.compareTo(targetUser.id!) > 0)
        ? currentUser
        : targetUser;
  }

  UserModel getReceiver(UserModel currentUser, UserModel targetUser) {
    String currentUserId = currentUser.id!;

    String targetUserId = targetUser.id!;

    return (currentUserId.compareTo(targetUser.id!) > 0)
        ? targetUser
        : currentUser;
  }

  Future<void> sendMessage(
      String targetId, String message, UserModel targetUser) async {
    String roomId = getRoomId(targetId);
    String chatId = uuid.v6();

    UserModel sender =
        getSender(profileController.currentUser.value, targetUser);
    UserModel receiver =
        getReceiver(profileController.currentUser.value, targetUser);
    if (selectedImagePath.value != "") {
      imageUrl.value = await uploadImageToCloudinary(selectedImagePath.value);
    }

    var newChat = ChatModel(
        message: message,
        id: chatId,
        imageUrl: imageUrl.value,
        senderId: auth.currentUser!.uid,
        receiverId: targetId,
        senderName: profileController.currentUser.value.name,
        timestamp: DateTime.now().toString());

    var roomDetails = ChatRoomModel(
        id: roomId,
        receiver: receiver,
        lastMessage: message,
        sender: sender,
        messages: [newChat],
        timeStamp: DateTime.now().toString(),
        unReadMessNo: 0,
        lastMessageTimeStamp: DateTime.now().toString());

    try {
      await db
          .collection("chats")
          .doc(roomId)
          .collection("messages")
          .doc(chatId)
          .set(newChat.toJson());
      await db.collection("chats").doc(roomId).set(roomDetails.toJson());
      print(chatId);
      await contactController.saveContact(targetUser);
      selectedImagePath.value = "";
      isLoading.value = false;
    } catch (e) {
      log(e.toString());

      isLoading.value = false;
    }
  }

  Stream<List<ChatModel>> getMessage(String targetId) {
    String roomId = getRoomId(targetId);
    return db
        .collection("chats")
        .doc(roomId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => ChatModel.fromJson(doc.data()),
            )
            .toList());
  }

  Stream<UserModel> getStatus(String uid) {
    return db
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((event) => UserModel.fromJson(event.data()!));
  }

  Stream<List<CallModel>> getCalls() {
    return db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("calls")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CallModel.fromJson(doc.data()))
            .toList());
  }
}

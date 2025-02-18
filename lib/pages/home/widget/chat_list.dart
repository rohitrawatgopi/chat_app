import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_chat/config/images.dart';
import 'package:my_chat/controller/auth.dart';
import 'package:my_chat/controller/contact.dart';
import 'package:my_chat/controller/profile.dart';
import 'package:my_chat/pages/chat/chat.dart';
import 'package:my_chat/pages/home/widget/chat_tile.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    AuthController authController = Get.put(AuthController());

    ProfileController profileController = Get.put(ProfileController());
    String? formattedTime;
    return RefreshIndicator(
        child: Obx(() => ListView(
            children: contactController.chatRoomList
                .map((e) => InkWell(
                    onTap: () {
                      DateTime nowTime =
                          DateTime.parse(e.lastMessageTimeStamp.toString());

                      formattedTime =
                          DateFormat('hh:mm a').format(nowTime).toString();

                      Get.to(ChatScreen(
                          userModel: (e.receiver!.id ==
                                  profileController.currentUser.value.id
                              ? e.sender
                              : e.receiver)!));
                    },
                    child: ChatTile(
                      name: (e.receiver!.id ==
                                  profileController.currentUser.value.id
                              ? e.sender!.name
                              : e.receiver!.name) ??
                          ImageAssets.DefaultImageURL,
                      lastChat: e.lastMessage ?? "Last Message ",
                      imgURL: (e.receiver!.id ==
                                  profileController.currentUser.value.id
                              ? e.sender!.userProfileUrl
                              : e.receiver!.userProfileUrl) ??
                          ImageAssets.DefaultImageURL,
                      time: formattedTime ?? "Last Time",
                    )))
                .toList())),
        onRefresh: () {
          return contactController.getChatRoomList();
        });
  }
}

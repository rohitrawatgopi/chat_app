import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:my_chat/config/images.dart';
import 'package:my_chat/contact/widget/contact_saerch.dart';
import 'package:my_chat/contact/widget/new_contact_tile.dart';
import 'package:my_chat/controller/chat_controller.dart';
import 'package:my_chat/controller/contact.dart';
import 'package:my_chat/controller/profile.dart';
import 'package:my_chat/pages/chat/chat.dart';
import 'package:my_chat/pages/group/widget/new_group.dart';
import 'package:my_chat/pages/home/widget/chat_tile.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    ContactController contactController = Get.put(ContactController());
    ProfileController profileController = Get.put(ProfileController());
    RxBool isSearch = false.obs;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          " Select contacts",
        ),
        actions: [
          Obx(() => IconButton(
              onPressed: () {
                isSearch.value = !isSearch.value;
              },
              icon: isSearch.value
                  ? const Icon(Icons.close)
                  : Icon(Icons.search)))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(children: [
          Column(
            children: [
              Obx(
                () => isSearch.value ? ContactSearch() : Gap(1),
              ),
              NewContactTile(
                  btName: "New Contact",
                  iconData: Icons.person_add,
                  onTap: () {}),
              Gap(10),
              NewContactTile(
                  btName: "New Group ",
                  iconData: Icons.group_add,
                  onTap: () {
                    Get.to(NewGroupScreen());
                  }),
              Row(
                children: [
                  Text("Contact on sampark"),
                ],
              ),
              Obx(() => Column(
                    children: contactController.userList
                        .map((e) => InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                Get.to(ChatScreen(userModel: e));

                                String roomID = chatController.getRoomId(e.id!);
                                print(roomID);
                              },
                              child: ChatTile(
                                  name: e.name ?? "USer",
                                  lastChat: e.about ?? "hii there",
                                  imgURL: e.userProfileUrl ??
                                      ImageAssets.DefaultImageURL,
                                  time: e.email ==
                                          profileController
                                              .currentUser.value.email
                                      ? "You"
                                      : ""),
                            ))
                        .toList(),
                  ))
            ],
          ),
        ]),
      ),
    );
  }
}

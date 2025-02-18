import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_chat/config/images.dart';
import 'package:my_chat/controller/group.dart';
import 'package:my_chat/pages/group_chat/group_chat.dart';
import 'package:my_chat/pages/home/widget/chat_tile.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());

    String? formattedTime;
    return Obx(() => ListView(
          children: groupController.groupList
              .map((e) => InkWell(
                    onTap: () {
                      DateTime nowTime = DateTime.parse(e.timeStamp.toString());

                      formattedTime =
                          DateFormat('hh:mm a').format(nowTime).toString();
                      Get.to(GroupChatScreen(groupModel: e));
                    },
                    child: ChatTile(
                        name: e.name.toString(),
                        lastChat: "Group",
                        imgURL: e.profileUrl ?? ImageAssets.DefaultImageURL,
                        time: formattedTime ?? ""),
                  ))
              .toList(),
        ));
  }
}

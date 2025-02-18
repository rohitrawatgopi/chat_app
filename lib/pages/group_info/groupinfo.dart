// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:my_chat/config/images.dart';
import 'package:my_chat/controller/image_picker.dart';
import 'package:my_chat/controller/profile.dart';
import 'package:my_chat/model/group.dart';
import 'package:my_chat/pages/group_info/group_member_info.dart';
import 'package:my_chat/pages/home/widget/chat_tile.dart';

class GroupInfoScreen extends StatelessWidget {
  final GroupModel groupModel;
  GroupInfoScreen({
    Key? key,
    required this.groupModel,
  }) : super(key: key);

  final RxBool isEdit = false.obs;

  RxString imagePath = "".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(groupModel.name!),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(children: [
          GroupMemberInfo(
              groupId: groupModel.id!,
              userName: groupModel.name!,
              userEmail: groupModel.description ?? "No Description Available",
              userProfileImg: groupModel.profileUrl ?? ImageAssets.deleteSvg),
          Gap(20),
          Text(
            "members",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Gap(20),
          Column(
            children: groupModel.members!
                .map((e) => ChatTile(
                      name: e.name!,
                      lastChat: e.email!,
                      imgURL: e.userProfileUrl ?? ImageAssets.DefaultImageURL,
                      time: e.role == "admin" ? "Admin" : "User",
                    ))
                .toList(),
          ),
        ]),
      ),
    );
  }
}

ProfileController profileController = Get.put(ProfileController());
ImagePIckerController imagePIckerController = Get.put(ImagePIckerController());

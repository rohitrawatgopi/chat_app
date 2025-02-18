import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_chat/config/images.dart';
import 'package:my_chat/controller/group.dart';
import 'package:my_chat/controller/image_picker.dart';
import 'package:my_chat/pages/home/widget/chat_tile.dart';

class GroupTitleScreen extends StatelessWidget {
  const GroupTitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());

    RxString groupName = "".obs;
    ImagePIckerController imagePIckerController =
        Get.put(ImagePIckerController());
    RxBool isEdit = false.obs;

    RxString imagePath = "".obs;
    return Scaffold(
      floatingActionButton: Obx(() => FloatingActionButton(
            backgroundColor: groupName.isEmpty
                ? Colors.grey
                : Theme.of(context).colorScheme.primary,
            onPressed: () {
              if (groupName.isEmpty) {
                Get.snackbar("Name is empty", "Please Enter Group Name");
              } else {
                groupController.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Colors.white,
                      ))
                    : groupController.createGroup(
                        groupName.value, imagePath.value);
              }
            },
            child: Icon(
              Icons.done,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          )),
      appBar: AppBar(
        title: Text("New Group"),
      ),
      body: Column(
        children: [
          Gap(10),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Obx(
                        () => InkWell(
                          onTap: () async {
                            imagePath.value = await imagePIckerController
                                .pickImage(ImageSource.gallery);
                          },
                          child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                              child: imagePath.value == ""
                                  ? Icon(
                                      Icons.group,
                                      size: 40,
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.file(
                                        File(
                                          imagePath.value,
                                        ),
                                        fit: BoxFit.cover,
                                      ))),
                        ),
                      ),
                      Gap(10),
                      TextFormField(
                        onChanged: (val) {
                          groupName.value = val;
                        },
                        decoration: InputDecoration(hintText: "Group Name"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Gap(20),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: groupController.groupMember
                  .map((e) => ChatTile(
                      name: e.name!,
                      lastChat: e.about ?? "",
                      imgURL: e.userProfileUrl ?? ImageAssets.DefaultImageURL,
                      time: ""))
                  .toList(),
            ),
          ))
        ],
      ),
    );
  }
}

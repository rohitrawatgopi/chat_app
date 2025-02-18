// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_chat/config/images.dart';
import 'package:my_chat/controller/group.dart';
import 'package:my_chat/controller/profile.dart';
import 'package:my_chat/model/group.dart';
import 'package:my_chat/pages/chat/widget/chat_Bubble.dart';
import 'package:my_chat/pages/group_chat/widget/group.type.dart';
import 'package:my_chat/pages/group_info/groupinfo.dart';

class GroupChatScreen extends StatelessWidget {
  GroupModel groupModel;
  GroupChatScreen({
    Key? key,
    required this.groupModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {},
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        groupModel.profileUrl ?? ImageAssets.DefaultImageURL,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Get.to(GroupInfoScreen(
                  groupModel: groupModel,
                ));
              },
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        groupModel.name ?? "Group name",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        "Online",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.phone)),
          IconButton(onPressed: () {}, icon: Icon(Icons.video_call))
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    StreamBuilder(
                        stream: groupController.groupMessages(groupModel.id!),
                        builder: (context, snapshot) {
                          print(snapshot.data.toString());
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.data == null) {
                            return Center(
                              child: Text("No message"),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text("Errror"),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: ListView.builder(
                                  reverse: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    print(snapshot.data!.length.toString());

                                    DateTime timeStamp = DateTime.parse(
                                        snapshot.data![index].timestamp!);

                                    String formattedTime =
                                        DateFormat('hh:mm a').format(timeStamp);
                                    return ChatBubble(
                                        message: snapshot.data![index].message!,
                                        isComing:
                                            snapshot.data![index].senderId !=
                                                    profileController
                                                        .currentUser.value.id
                                                ? true
                                                : false,
                                        time: formattedTime,
                                        status: "read",
                                        imgURL:
                                            snapshot.data![index].imageUrl ??
                                                "");
                                  }),
                            );
                          }
                        }),
                    Obx(() => groupController.selectedImagePath.value != ""
                        ? Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(
                                            File(
                                              groupController
                                                  .selectedImagePath.value,
                                            ),
                                          ),
                                          fit: BoxFit.contain),
                                      borderRadius: BorderRadius.circular(15),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                                  height: 500,
                                ),
                                Positioned(
                                    right: 0,
                                    child: IconButton(
                                        onPressed: () {
                                          groupController
                                              .selectedImagePath.value = "";
                                        },
                                        icon: Icon(Icons.close))),
                              ],
                            ))
                        : Container()),
                  ],
                ),
              ),
              TypeGroupMessage(groupModel: groupModel),
            ],
          )),
    );
  }
}

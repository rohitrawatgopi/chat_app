// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_chat/config/images.dart';
import 'package:my_chat/controller/call.controller.dart';
import 'package:my_chat/controller/chat_controller.dart';
import 'package:my_chat/controller/profile.dart';
import 'package:my_chat/model/user.dart';
import 'package:my_chat/pages/call/audio.call.dart';
import 'package:my_chat/pages/call/video.call.dart';
import 'package:my_chat/pages/chat/widget/chat_Bubble.dart';
import 'package:my_chat/pages/chat/widget/type_msg.dart';
import 'package:my_chat/pages/userProfile/profile.dart';

class ChatScreen extends StatelessWidget {
  UserModel userModel;
  ChatScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    ProfileController profileController = Get.put(ProfileController());
    CallController callController = Get.put(CallController());
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
                onTap: () {
                  Get.to(UserProfileScreen(userModel: userModel));
                },
                child: Container(
                  height: 45,
                  width: 45,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: userModel.userProfileUrl ??
                          ImageAssets.DefaultImageURL,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Get.to(UserProfileScreen(userModel: userModel));
                },
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 75,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            userModel.name ?? "user",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        StreamBuilder(
                            stream: chatController.getStatus(userModel.id!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("......");
                              } else if (snapshot.hasData) {
                                return Text(
                                  snapshot.data!.status ?? "online",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: snapshot.data!.status == "Online"
                                          ? Colors.green
                                          : Colors.grey),
                                );
                              } else {
                                return Gap(1);
                              }
                            })
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(AudioCallScreen(target: userModel));

                callController.callAnyOne(
                    userModel, profileController.currentUser.value, "audio");
              },
              icon: Icon(Icons.phone)),
          IconButton(
              onPressed: () {
                Get.to(VideoCallScreen(target: userModel));

                callController.callAnyOne(
                    userModel, profileController.currentUser.value, "video");
              },
              icon: Icon(Icons.video_call))
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
                        stream: chatController.getMessage(userModel.id!),
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
                              padding: const EdgeInsets.only(bottom: 2),
                              child: ListView.builder(
                                  reverse: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    print(snapshot.data!.length.toString());
                                    DateTime nowTime = DateTime.parse(
                                        snapshot.data![index].timestamp!);

                                    String formattedTime = DateFormat('hh:mm a')
                                        .format(nowTime)
                                        .toString();

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
                    Obx(() => chatController.selectedImagePath.value != ""
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
                                              chatController
                                                  .selectedImagePath.value,
                                            ),
                                          ),
                                          fit: BoxFit.contain),
                                      borderRadius: BorderRadius.circular(15),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  height: 500,
                                ),
                                Positioned(
                                    right: 0,
                                    child: IconButton(
                                        onPressed: () {
                                          chatController
                                              .selectedImagePath.value = "";
                                        },
                                        icon: Icon(Icons.close))),
                              ],
                            ))
                        : Container()),
                  ],
                ),
              ),
              TypeMessage(userModel: userModel),
            ],
          )),
    );
  }
}

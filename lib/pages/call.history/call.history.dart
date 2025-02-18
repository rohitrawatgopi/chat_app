import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_chat/config/images.dart';
import 'package:my_chat/controller/chat_controller.dart';
import 'package:my_chat/pages/home/widget/chat_tile.dart';

class CallHistoryScreen extends StatelessWidget {
  const CallHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());

    return StreamBuilder(
        stream: chatController.getCalls(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ChatTile(
                      name: snapshot.data![index].callerName ?? "......",
                      lastChat: snapshot.data![index].time ?? "",
                      imgURL: snapshot.data![index].callerPic ??
                          ImageAssets.DefaultImageURL,
                      time: "22");
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_chat/config/string.dart';
import 'package:my_chat/controller/chat_controller.dart';
import 'package:my_chat/controller/profile.dart';
import 'package:my_chat/model/user.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class AudioCallScreen extends StatelessWidget {
  final UserModel target;

  const AudioCallScreen({
    Key? key,
    required this.target,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    ChatController chatController = Get.put(ChatController());

    var callId = chatController.getRoomId(target.id!);
    return ZegoUIKitPrebuiltCall(
      appID: ZegoCloudConfig.appId,
      appSign: ZegoCloudConfig.appSign,
      userID: profileController.currentUser.value.id ?? "root",
      userName: profileController.currentUser.value.name ?? "root",
      callID: callId,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    );
  }
}

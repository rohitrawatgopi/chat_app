// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:my_chat/config/images.dart';
import 'package:my_chat/controller/chat_controller.dart';
import 'package:my_chat/controller/image_picker.dart';
import 'package:my_chat/model/user.dart';
import 'package:my_chat/widget/image_picker_bottom.dart';

class TypeMessage extends StatelessWidget {
  final UserModel userModel;
  const TypeMessage({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    ImagePIckerController imagePIckerController =
        Get.put(ImagePIckerController());
    TextEditingController messageController = TextEditingController();
    RxString message = "".obs;
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            child: SvgPicture.asset(
              color: Colors.amber,
              ImageAssets.emojiSvg,
              width: 25,
            ),
          ),
          Gap(10),
          Expanded(
              child: TextFormField(
            onChanged: (val) {
              message.value = val;
            },
            controller: messageController,
            decoration:
                InputDecoration(filled: false, hintText: "Type message......"),
          )),
          Gap(10),
          Obx(() => chatController.selectedImagePath.value == ""
              ? InkWell(
                  onTap: () async {
                    imagePickerBottomSheet(
                        context,
                        chatController.selectedImagePath,
                        imagePIckerController);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      ImageAssets.galleryIconSvg,
                      width: 25,
                    ),
                  ),
                )
              : Gap(1)),
          Gap(10),
          Obx(() => message.value != "" ||
                  message.value.isNotEmpty ||
                  chatController.selectedImagePath.value != ""
              ? InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    if (messageController.text.isNotEmpty ||
                        messageController.text != "" ||
                        chatController.selectedImagePath != "") {
                      chatController.sendMessage(
                          userModel.id!, messageController.text, userModel);
                      message.value = "";
                      messageController.clear();
                    }
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    child: chatController.isLoading.value
                        ? CircularProgressIndicator()
                        : SvgPicture.asset(
                            ImageAssets.sendIconSvg,
                          ),
                  ),
                )
              : Container(
                  width: 30,
                  height: 30,
                  child: SvgPicture.asset(
                    ImageAssets.micSvg,
                    width: 25,
                  ),
                )),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_chat/controller/image_picker.dart';

Future<dynamic> imagePickerBottomSheet(BuildContext context, RxString imagePath,
    ImagePIckerController imagePIckerController) {
  return Get.bottomSheet(Container(
    height: 150,
    decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () async {
            imagePath.value =
                await imagePIckerController.pickImage(ImageSource.camera);
            Get.back();
          },
          child: Container(
            height: 70,
            width: 70,
            child: Icon(
              Icons.camera,
              size: 30,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.background),
          ),
        ),
        InkWell(
          onTap: () async {
            imagePath.value =
                await imagePIckerController.pickImage(ImageSource.gallery);
            Get.back();
          },
          child: Container(
            height: 70,
            width: 70,
            child: Icon(
              Icons.photo,
              size: 30,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.background),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            height: 70,
            width: 70,
            child: Icon(
              Icons.play_arrow,
              size: 30,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.background),
          ),
        )
      ],
    ),
  ));
}

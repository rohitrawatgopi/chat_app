import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_chat/config/images.dart';
import 'package:my_chat/controller/auth.dart';
import 'package:my_chat/controller/image_picker.dart';
import 'package:my_chat/controller/profile.dart';
import 'package:my_chat/widget/primary_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

ProfileController profileController = Get.put(ProfileController());
ImagePIckerController imagePIckerController = Get.put(ImagePIckerController());
AuthController authController = Get.put(AuthController());

class _ProfileScreenState extends State<ProfileScreen> {
  final RxBool isEdit = false.obs;
  RxString imagePath = "".obs;

  final TextEditingController name =
      TextEditingController(text: profileController.currentUser.value.name);
  final TextEditingController email =
      TextEditingController(text: profileController.currentUser.value.email);
  final TextEditingController about =
      TextEditingController(text: profileController.currentUser.value.about);
  final TextEditingController phone = TextEditingController(
      text: profileController.currentUser.value.phoneNumber);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
              onPressed: () {
                authController.logOutUser();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              ),
              child: Column(
                children: [
                  const Gap(20),
                  Obx(() => isEdit.value
                      ? InkWell(
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            imagePath.value = await imagePIckerController
                                .pickImage(ImageSource.gallery);
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Theme.of(context).colorScheme.background,
                            ),
                            child: imagePath.value == ""
                                ? Icon(Icons.add, size: 40, color: Colors.white)
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.file(
                                      File(imagePath.value),
                                      fit: BoxFit.cover,
                                    )),
                          ),
                        )
                      : Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: profileController
                                      .currentUser.value.userProfileUrl ==
                                  null
                              ? Icon(Icons.edit, size: 40, color: Colors.white)
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    imageUrl: profileController
                                            .currentUser.value.userProfileUrl ??
                                        ImageAssets.DefaultImageURL,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                        )),
                  const Gap(20),
                  Obx(() => TextField(
                        controller: name,
                        enabled: isEdit.value,
                        decoration: const InputDecoration(
                          filled: false,
                          prefixIcon: Icon(Icons.person),
                          labelText: "Name",
                        ),
                      )),
                  const Gap(20),
                  Obx(() => TextField(
                        controller: about,
                        enabled: isEdit.value,
                        decoration: const InputDecoration(
                          filled: false,
                          prefixIcon: Icon(Icons.info),
                          labelText: "About",
                        ),
                      )),
                  const Gap(20),
                  TextField(
                    controller: email,
                    enabled: false, // Email is usually not editable
                    decoration: const InputDecoration(
                      filled: false,
                      prefixIcon: Icon(Icons.email),
                      labelText: "Email",
                    ),
                  ),
                  const Gap(20),
                  Obx(() => TextField(
                        controller: phone,
                        enabled: isEdit.value,
                        decoration: const InputDecoration(
                          filled: false,
                          prefixIcon: Icon(Icons.phone),
                          labelText: "Phone",
                        ),
                      )),
                  const Gap(20),
                  Obx(() => PrimaryButton(
                        btName: isEdit.value ? "Save" : "Edit",
                        icon: isEdit.value ? Icons.save : Icons.edit,
                        onTap: () {
                          isEdit.value
                              ? profileController.updateProfile(
                                  name.text,
                                  imagePath.value,
                                  about.text,
                                  phone.text,
                                )
                              : () {};
                          isEdit.value = !isEdit.value;
                        },
                      )),
                  const Gap(20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

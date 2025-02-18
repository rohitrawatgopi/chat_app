import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:my_chat/controller/auth.dart';
import 'package:my_chat/widget/primary_button.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();

    TextEditingController password = TextEditingController();
    TextEditingController name = TextEditingController();

    AuthController authController = Get.put(AuthController());

    return Column(
      children: [
        TextField(
          controller: name,
          decoration: InputDecoration(
              hintText: "Full Name", prefixIcon: Icon(Icons.person)),
        ),
        Gap(20),
        TextField(
          controller: email,
          decoration: InputDecoration(
              hintText: "Email",
              prefixIcon: Icon(Icons.alternate_email_rounded)),
        ),
        Gap(20),
        TextField(
          controller: password,
          decoration: InputDecoration(
              hintText: "Password", prefixIcon: Icon(Icons.password_outlined)),
        ),
        Gap(20),
        Obx(() => authController.isLoading.value
            ? CircularProgressIndicator()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  authController.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : PrimaryButton(
                          btName: "SingUp",
                          icon: Icons.lock_open_outlined,
                          onTap: () {
                            authController.createUser(
                                email.text, password.text, name.text);
                          },
                        ),
                ],
              ))
      ],
    );
  }
}

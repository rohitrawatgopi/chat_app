import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:my_chat/controller/auth.dart';
import 'package:my_chat/widget/primary_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();

    TextEditingController password = TextEditingController();

    AuthController authController = Get.put(AuthController());

    return Column(
      children: [
        TextField(
          controller: email,
          decoration: InputDecoration(
              hintText: "Email",
              prefixIcon: Icon(Icons.alternate_email_rounded)),
        ),
        Gap(40),
        TextField(
          controller: password,
          decoration: InputDecoration(
              hintText: "Password", prefixIcon: Icon(Icons.password_outlined)),
        ),
        Gap(40),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                authController.isLoading.value
                    ? CircularProgressIndicator()
                    : PrimaryButton(
                        btName: "Login",
                        icon: Icons.lock_open_outlined,
                        onTap: () {
                          authController.login(email.text, password.text);
                          //    Get.offAllNamed("/homeScreen");
                        },
                      ),
              ],
            ))
      ],
    );
  }
}

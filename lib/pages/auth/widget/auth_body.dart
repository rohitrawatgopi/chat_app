import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:my_chat/pages/auth/widget/login_form.dart';
import 'package:my_chat/pages/auth/widget/signup_form.dart';

class AuthScreenBody extends StatelessWidget {
  const AuthScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isLogin = true.obs;
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              child: Column(
            children: [
              Obx(
                () => Row(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        isLogin.value = true;
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Column(
                          children: [
                            Text(
                              "Login",
                              style: isLogin.value
                                  ? Theme.of(context).textTheme.bodyLarge
                                  : Theme.of(context).textTheme.labelLarge,
                            ),
                            Gap(5),
                            AnimatedContainer(
                                width: isLogin.value ? 100 : 0,
                                height: 3,
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                duration: Duration(milliseconds: 200))
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        isLogin.value = false;
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Column(
                          children: [
                            Text(
                              "SingUp",
                              style: isLogin.value
                                  ? Theme.of(context).textTheme.labelLarge
                                  : Theme.of(context).textTheme.bodyLarge,
                            ),
                            Gap(5),
                            AnimatedContainer(
                                width: isLogin.value ? 0 : 100,
                                height: 3,
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                duration: Duration(milliseconds: 200))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(20),
              Obx(() => isLogin.value ? LoginForm() : SignupForm()),
              Gap(20),
            ],
          ))
        ],
      ),
    );
  }
}

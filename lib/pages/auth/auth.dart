import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:my_chat/pages/auth/widget/auth_body.dart';
import 'package:my_chat/pages/onBoard/widget/onboard_head.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [Gap(50), OnBoardHead(), Gap(120), AuthScreenBody()],
            ),
          ),
        ),
      ),
    );
  }
}

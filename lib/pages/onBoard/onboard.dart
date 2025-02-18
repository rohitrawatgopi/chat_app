import 'package:flutter/material.dart';
import 'package:my_chat/pages/onBoard/widget/onboard_body.dart';
import 'package:my_chat/pages/onBoard/widget/onboard_foot.dart';
import 'package:my_chat/pages/onBoard/widget/onboard_head.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          OnBoardHead(),
          OnBoardBody(),
          OnBoardFooter(),
        ],
      )),
    );
  }
}

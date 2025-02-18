import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:my_chat/config/images.dart';
import 'package:my_chat/config/string.dart';

class OnBoardHead extends StatelessWidget {
  const OnBoardHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          ImageAssets.appIconSvg,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        Gap(30),
        Text(AppString.appName,
            style: Theme.of(context).textTheme.headlineLarge),
      ],
    );
  }
}

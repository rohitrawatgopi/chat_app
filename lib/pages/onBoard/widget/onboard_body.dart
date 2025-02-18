import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:my_chat/config/images.dart';
import 'package:my_chat/config/string.dart';

class OnBoardBody extends StatelessWidget {
  const OnBoardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageAssets.boyImage),
            SvgPicture.asset(ImageAssets.plugIconSvg),
            Image.asset(ImageAssets.girlImage),
          ],
        ),
        Gap(30),
        Text(
          OnBoardScreeString.nowYouAre,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          OnBoardScreeString.connected,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Gap(30),
        Text(
          textAlign: TextAlign.center,
          OnBoardScreeString.description,
          style: Theme.of(context).textTheme.labelLarge,
        )
      ],
    );
  }
}

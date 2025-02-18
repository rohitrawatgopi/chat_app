import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_chat/config/images.dart';
import 'package:my_chat/config/string.dart';
import 'package:slide_to_act/slide_to_act.dart';

class OnBoardFooter extends StatelessWidget {
  const OnBoardFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideAction(
      text: OnBoardScreeString.slideToStart,
      textStyle: Theme.of(context).textTheme.labelLarge,
      animationDuration: Duration(),
      submittedIcon: SvgPicture.asset(
        ImageAssets.plugIconSvg,
        width: 25,
      ),
      sliderRotate: false,
      sliderButtonIcon: Container(
        width: 25,
        height: 25,
        child: SvgPicture.asset(
          ImageAssets.plugIconSvg,
          width: 25,
        ),
      ),
      innerColor: Theme.of(context).colorScheme.primary,
      outerColor: Theme.of(context).colorScheme.primaryContainer,
      onSubmit: () {
        Get.offNamed("/authScreen");
      },
    );
  }
}

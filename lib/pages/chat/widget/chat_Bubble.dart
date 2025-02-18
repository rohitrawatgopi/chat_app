import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:my_chat/config/images.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isComing;

  final String time;
  final String status;
  final String imgURL;

  const ChatBubble(
      {super.key,
      required this.message,
      required this.isComing,
      required this.time,
      required this.status,
      required this.imgURL});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 10),
      child: Column(
        crossAxisAlignment:
            isComing ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
              minWidth: 100,
              maxWidth: MediaQuery.of(context).size.width / 1.3,
            ),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: isComing
                    ? BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
            child: imgURL.isEmpty
                ? Flexible(child: Text(message))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: imgURL,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      message.isNotEmpty ? Gap(10) : Gap(1),
                      message.isNotEmpty ? Text(message) : Gap(1)
                    ],
                  ),
          ),
          Gap(10),
          Row(
            mainAxisAlignment:
                isComing ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              isComing
                  ? Text(
                      time,
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  : Row(
                      children: [
                        Text(
                          time,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Gap(10),
                        SvgPicture.asset(
                          ImageAssets.chatStatusSvg,
                          width: 20,
                        ),
                      ],
                    ),
            ],
          )
        ],
      ),
    );
  }
}

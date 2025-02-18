import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:my_chat/config/images.dart';
import 'package:my_chat/controller/group.dart';
import 'package:my_chat/model/user.dart';

class GroupMemberInfo extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String userProfileImg;
  final String groupId;

  const GroupMemberInfo(
      {super.key,
      required this.userName,
      required this.userEmail,
      required this.userProfileImg,
      required this.groupId});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());

    return Container(
      padding: EdgeInsets.all(16),
      height: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: userProfileImg,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userName,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userEmail,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
              Gap(40),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Container(
                  height: 50,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.background),
                  child: Row(
                    children: [
                      SvgPicture.asset(ImageAssets.callSvg),
                      Gap(10),
                      Text("call")
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.background),
                    child: Row(
                      children: [
                        SvgPicture.asset(ImageAssets.callSvg),
                        Gap(10),
                        Text(
                          "video",
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    var newMember = UserModel(email: "s", name: userName);

                    groupController.addMemberTOGroup(groupId, newMember);
                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.background),
                    child: Row(
                      children: [
                        SvgPicture.asset(ImageAssets.addUserSvg),
                        Gap(10),
                        Text("Add")
                      ],
                    ),
                  ),
                )
              ]),
            ],
          ))
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_chat/config/images.dart';
import 'package:my_chat/controller/group.dart';

class SelectedMember extends StatelessWidget {
  const SelectedMember({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    return Obx(
      () => Row(
        children: groupController.groupMember
            .map((e) => Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 70,
                      width: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl:
                              e.userProfileUrl ?? ImageAssets.DefaultImageURL,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: InkWell(
                        onTap: () {
                          groupController.groupMember.remove(e);
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  weight: 20,
                                  size: 15,
                                )),
                          ),
                        ),
                      ),
                    )
                  ],
                ))
            .toList(),
      ),
    );
  }
}

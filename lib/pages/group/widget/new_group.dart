import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:my_chat/config/images.dart';
import 'package:my_chat/controller/contact.dart';
import 'package:my_chat/controller/group.dart';
import 'package:my_chat/pages/group/widget/gropu_title.dart';
import 'package:my_chat/pages/group/widget/selected.dart';
import 'package:my_chat/pages/home/widget/chat_tile.dart';

class NewGroupScreen extends StatelessWidget {
  const NewGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    GroupController groupController = Get.put(GroupController());
    return Scaffold(
        body: Scaffold(
            floatingActionButton: Obx(
              () => FloatingActionButton(
                backgroundColor: groupController.groupMember.isEmpty
                    ? Colors.grey
                    : Theme.of(context).colorScheme.primary,
                onPressed: () {
                  if (groupController.groupMember.isEmpty) {
                    Get.snackbar("Error", "please select  at least one member");
                  } else {
                    Get.to(GroupTitleScreen());
                  }
                },
                child: Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
            appBar: AppBar(
              title: Text("New Group"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SelectedMember(),
                  Gap(10),
                  Text(
                    "Contacts on sampark",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Gap(10),
                  Expanded(
                    child: StreamBuilder(
                        stream: contactController.getContacts(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          {
                            print(snapshot.data.toString());
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.data == null) {
                              return Center(
                                child: Text("No message"),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text("Errror"),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 90),
                                child: ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      print(snapshot.data!.length.toString());

                                      return GestureDetector(
                                        onTap: () {
                                          groupController.selectMembers(
                                              snapshot.data[index]);
                                        },
                                        child: ChatTile(
                                            name: snapshot.data[index].name,
                                            lastChat:
                                                snapshot.data[index].about ??
                                                    "",
                                            imgURL: snapshot.data[index]
                                                    .userProfileUrl ??
                                                ImageAssets.DefaultImageURL,
                                            time: "s"),
                                      );
                                    }),
                              );
                            }
                          }
                        }),
                  ),
                ],
              ),
            )));
  }
}

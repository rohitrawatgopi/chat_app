import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_chat/config/images.dart';
import 'package:my_chat/config/string.dart';
import 'package:my_chat/controller/contact.dart';
import 'package:my_chat/controller/profile.dart';
import 'package:my_chat/controller/status.dart';
import 'package:my_chat/pages/call.history/call.history.dart';
import 'package:my_chat/pages/group/group.dart';
import 'package:my_chat/pages/home/widget/chat_list.dart';
import 'package:my_chat/pages/home/widget/tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    ProfileController profileController = Get.put(ProfileController());
    ContactController contactController = Get.put(ContactController());

    StatusController statusController = Get.put(StatusController());

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            Get.toNamed("/contactScreen");
          },
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        appBar: AppBar(
          bottom: myTabBar(tabController, context),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              ImageAssets.appIconSvg,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: Text(
            AppString.appName,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed("profileScreen");
                },
                icon: Icon(Icons.more_vert))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
              controller: tabController,
              children: [ChatList(), GroupScreen(), CallHistoryScreen()]),
        ));
  }
}

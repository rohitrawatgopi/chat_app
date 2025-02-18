import 'package:flutter/material.dart';

myTabBar(tabController, BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: TabBar(
        unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
        labelStyle: Theme.of(context).textTheme.bodyLarge,
        controller: tabController,
        indicatorWeight: 4,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [Text("Chat"), Text("Groups"), Text("Calls")]),
  );
}

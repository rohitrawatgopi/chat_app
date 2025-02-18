// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:my_chat/model/user.dart';
import 'package:my_chat/pages/userProfile/widget/profile_head.dart';

class UserProfileScreen extends StatelessWidget {
  final UserModel userModel;
  const UserProfileScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
        title: Text("UserProfile"),
      ),
      body: Column(
        children: [
          UserProfileHead(
            userEmail: userModel.email!,
            userName: userModel.name!,
            userProfileImg: userModel.userProfileUrl ?? "",
          )
        ],
      ),
    );
  }
}

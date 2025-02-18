import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:my_chat/contact/widget/new_contact_tile.dart';

class ContactHead extends StatelessWidget {
  const ContactHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                textInputAction: TextInputAction.done,
                onSubmitted: (val) {},
                decoration: InputDecoration(
                    hintText: "Search contact", prefixIcon: Icon(Icons.search)),
              ))
            ],
          ),
        ),
        NewContactTile(
            btName: "New Contact", iconData: Icons.person_add, onTap: () {}),
        Gap(10),
        NewContactTile(
            btName: "New Group ", iconData: Icons.group_add, onTap: () {}),
        Row(
          children: [
            Text("Contact on sampark"),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NewContactTile extends StatelessWidget {
  final String btName;
  final IconData iconData;
  final VoidCallback onTap;
  const NewContactTile(
      {super.key,
      required this.btName,
      required this.iconData,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(100)),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    iconData,
                    size: 30,
                  )),
            ),
            Gap(20),
            Text(
              btName,
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}

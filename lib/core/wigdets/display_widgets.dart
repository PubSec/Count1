import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class DisplayWidgets extends StatefulWidget {
  const DisplayWidgets({super.key});

  @override
  State<DisplayWidgets> createState() => _DisplayWidgetsState();
}

class _DisplayWidgetsState extends State<DisplayWidgets> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {},
          child: InkWell(
            splashColor: Colors.red,
            child: HugeIcon(
                icon: HugeIcons.strokeRoundedMinusSign,
                size: 50,
                color: Colors.black),
          ),
        ),
        Column(
          children: [
            Container(
                child: Text(
              'Title',
              style: TextStyle(fontSize: 20),
            )),
            Container(
                child: Text(
              'number',
              style: TextStyle(fontSize: 20),
            )),
          ],
        ),
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("jkdsal")));
          },
          child: InkWell(
            splashColor: Colors.amber,
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedPlusSign,
              size: 50,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

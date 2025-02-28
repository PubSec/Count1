import 'package:flutter/material.dart';

class DisplayWidgets extends StatefulWidget {
  final String title;
  final String value;
  const DisplayWidgets({super.key, required this.title, required this.value});

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
          onTap: () {
            /// Decrease a
          },
          child: InkWell(
            splashColor: Colors.red,
            child: Icon(Icons.add_ic_call_outlined),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.title, style: TextStyle(fontSize: 20)),
            Text(widget.value, style: TextStyle(fontSize: 20)),
          ],
        ),
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Increased"),
                behavior: SnackBarBehavior.floating,
              ),
            );

            /// Increment one
          },
          child: InkWell(
            splashColor: Colors.amber,
            child: Icon(Icons.add_ic_call_outlined),
          ),
        ),
      ],
    );
  }
}

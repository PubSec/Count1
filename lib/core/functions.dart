import 'package:flutter/material.dart';

selectedButton(BuildContext context, item) {
  switch (item) {
    case 0:
      debugPrint('WIP');
      break;
    case 1:
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('About'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('This is a demo alert dialog.'),
                  Text('Would you like to approve of this message?'),
                ],
              ),
            ),
          );
        },
      );
  }
}

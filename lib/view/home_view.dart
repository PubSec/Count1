import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Count1"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Text("Switch Mode"),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text("About"),
              ),
            ],
            onSelected: (item) => selectedButton(context, item),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                child: Center(
                  child: Text('dsakdsa'),
                ),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.plus_one,
        ),
      ),
    );
  }
}

selectedButton(BuildContext context, item) {
  switch (item) {
    case 0:
      print('he');
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

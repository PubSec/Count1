import 'package:count1/core/functions.dart';
import 'package:count1/core/wigdets/display_widgets.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _titletextEditingController =
      TextEditingController();
  final TextEditingController _valuetextEditingController =
      TextEditingController();

  bool validDataEntered() {
    if (_titletextEditingController.text.isEmpty ||
        _valuetextEditingController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    _titletextEditingController;
    _valuetextEditingController;
    super.initState();
  }

  @override
  void dispose() {
    _titletextEditingController;
    _valuetextEditingController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        children: [DisplayWidgets(), DisplayWidgets()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (builder) => Container(
              padding: EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _titletextEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Title',
                      hintFadeDuration: Duration(milliseconds: 440),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _valuetextEditingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Initial value',
                      hintFadeDuration: Duration(milliseconds: 440),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        if (validDataEntered()) {
                          Navigator.of(context).pop();
                          _titletextEditingController.clear();
                          _valuetextEditingController.clear();
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content:
                                    Text('Title and value can\'t be empty'),
                              );
                            },
                          );
                        }
                      },
                      child: Text('Save'))
                ],
              ),
            ),
          );
        },
        child: Icon(HugeIcons.strokeRoundedPlusSign),
      ),
    );
  }
}

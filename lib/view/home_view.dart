import 'package:count1/core/functions.dart';
import 'package:count1/wigdets/display_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
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

  showDataBase() async {
    var databasesPath = await getDatabasesPath();
    String path = "$databasesPath/'test-db.db'";

    Database database = await openDatabase(
      path,
      version: 1,
      onOpen: (Database db) async {
        await db.execute('SELECT * FROM Name');
      },
    );
    // var data = database.query('Name');

    return database.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Count1"),
        actions: [
          PopupMenuButton(
            itemBuilder:
                (context) => [
                  PopupMenuItem<int>(value: 0, child: Text("Switch Mode")),
                  PopupMenuItem<int>(value: 1, child: Text("About")),
                ],
            onSelected: (item) => selectedButton(context, item),
          ),
        ],
      ),
      body: Text(showDataBase()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder:
                (builder) => Container(
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
                      SizedBox(height: 10),
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
                        onPressed: () async {
                          Database database = await openDatabase(
                            'test-db.db',
                            version: 1,
                            onCreate: (Database db, int version) async {
                              await db.execute(
                                'CREATE TABLE "Name" ("id"	INTEGER,"title"	TEXT,"count_number"	INTEGER,PRIMARY KEY("id" AUTOINCREMENT))',
                              );
                            },
                          );
                          await database.transaction((txn) async {
                            int id1 = await txn.rawInsert(
                              'INSERT INTO "Name" ("title", "count_number") VALUES ("${_titletextEditingController.text}", ${int.parse(_valuetextEditingController.text)})',
                            );
                            // ignore: unnecessary_brace_in_string_interps
                            print("Inserted to ${id1}");
                          });
                        },
                        child: Text('Save'),
                      ),
                    ],
                  ),
                ),
          );
        },
        child: Icon(Icons.plus_one),
      ),
    );
  }
}

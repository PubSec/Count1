import 'package:count1/model/entry_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

class DataProvider extends Notifier<Future<List<EntryModel>>> {
  @override
  build() {
    return Future.value([EntryModel(title: "No Entry", initialValue: 1)]);
  }

  Future<List<EntryModel>> showDataBase() async {
    var databasesPath = await getDatabasesPath();
    String path = "$databasesPath/'test-db.db'";

    Database database = await openDatabase(
      path,
      version: 1,
      onOpen: (Database db) async {
        await db.execute('SELECT * FROM Name').then((onValue) {});
      },
    );
    // var data = database.query('Name');
    List<EntryModel> entries = [EntryModel(title: "database", initialValue: 0)];
    return entries;
  }
}

final dataProviderNotifier =
    NotifierProvider<DataProvider, Future<List<EntryModel>>>(() {
      return DataProvider();
    });

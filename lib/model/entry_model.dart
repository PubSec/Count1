import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableCount = 'Count';
final String columnId = '_id';
final String columnEntryTitle = 'title';
final String columnEntryValue = 'value';

class EntryModel {
  int? id; // Make id nullable
  late String title;
  late int initialValue;

  EntryModel();

  // Convert EntryModel to a map
  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnEntryTitle: title,
      columnEntryValue: initialValue,
    };
    if (id != null) {
      map[columnId] = id; // Only add id if it's not null
    }
    return map;
  }

  // Create an EntryModel from a map
  EntryModel.fromMap(Map<String, Object?> map) {
    id = map[columnId] as int?;
    title = map[columnEntryTitle] as String;
    initialValue = map[columnEntryValue] as int;
  }
}

class EntryProvider {
  Database? db; // Make db nullable

  // Open the database
  Future<void> open() async {
    String dbPath = await getDatabasesPath();
    print("The path of the database is: $dbPath");
    String path = join(
      dbPath,
      tableCount,
    ); // Use path.join for cross-platform compatibility
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE $tableCount ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnEntryTitle TEXT NOT NULL, $columnEntryValue INTEGER NOT NULL)',
        );
      },
    );
  }

  // Insert a new EntryModel
  Future<EntryModel> insert(EntryModel entryModel) async {
    entryModel.id = await db!.insert(tableCount, entryModel.toMap());
    return entryModel;
  }

  // Get an EntryModel by id
  // Future<EntryModel?> getEntries(int id) async {
  //   List<Map<String, Object?>> maps = await db!.query(
  //     tableCount,
  //     columns: [columnId, columnEntryTitle, columnEntryValue],
  //     where: '$columnId = ?',
  //     whereArgs: [id],
  //   );
  //   if (maps.isNotEmpty) {
  //     return EntryModel.fromMap(maps.first);
  //   }
  //   return null; // Return null if no entry found
  // }

  // Fetch all entries

  Future<List<EntryModel>> getAllEntries() async {
    List<Map<String, Object?>> maps = await db!.query(tableCount);

    return List.generate(maps.length, (i) {
      return EntryModel.fromMap(maps[i]);
    });
  }

  // Delete an EntryModel by id
  Future<int> delete(int id) async {
    return await db!.delete(
      tableCount,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Close the database
  Future<void> close() async {
    await db?.close(); // Close if db is not null
  }
}

// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseConnection {
//   setDatabase() async {
//     var directory = await getApplicationDocumentsDirectory();
//     var path = join(directory.path, 'db_todolist_sqflite');
//     var database = await openDatabase(path, version: 2, onCreate: _onCreatingDatabase, onUpgrade: _onUpgrade);
//     return database;
//   }

//   _onCreatingDatabase(Database database, int version) async {
//     await database.execute(
//         "CREATE TABLE todos (id INTEGER PRIMARY KEY, title TEXT, description TEXT, category TEXT, todoDate TEXT, isFinished INTEGER)");
//     await database.execute(
//         "CREATE TABLE categories (id INTEGER PRIMARY KEY, name TEXT)");
//   }

//   _onUpgrade(Database database, int oldVersion, int newVersion) async {
//     if (oldVersion < 2) {
//       await database.execute(
//           "CREATE TABLE categories (id INTEGER PRIMARY KEY, name TEXT)");
//     }
//   }
// }

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_todolist_sqflite');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    await database.execute(
        "CREATE TABLE todos (id INTEGER PRIMARY KEY, title TEXT, description TEXT, category TEXT, todoDate TEXT, isFinished INTEGER)");
    await database
        .execute("CREATE TABLE categories (id INTEGER PRIMARY KEY, name TEXT)");
  }
}

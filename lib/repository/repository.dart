// import 'package:uas/repository/database_connection.dart';
// import 'package:sqflite/sqflite.dart';
// // import 'package:path/path.dart';
// // import 'package:path_provider/path_provider.dart';

// class Repository {
//   late DatabaseConnection _databaseConnection;
//   static Database? _dbTodo;
//   Repository() {
//     _databaseConnection = DatabaseConnection();
//   }

//   Future<Database> get dbTodo async {
//     if (_dbTodo != null) {
//       return _dbTodo!;
//     } else {
//       _dbTodo = await _databaseConnection.setDatabase();
//       return _dbTodo!;
//     }
//   }

//   insertData(table, data) async {
//     var connection = await dbTodo;
//     var result = connection.insert(table, data);
//     return result;
//   }

//   readData(table) async {
//     var connection = await dbTodo;
//     var result = await connection.query(table);
//     return result;
//   }

//   readDataById(table, itemId) async {
//     var connection = await dbTodo;
//     var result =
//         await connection.query(table, where: 'id=?', whereArgs: [itemId]);
//     return result;
//   }

//   updateData(table, data) async {
//     var connection = await dbTodo;
//     var result = await connection
//         .update(table, data, where: 'id=?', whereArgs: [data['id']]);
//     return result;
//   }

//   deleteData(table, itemId) async {
//     var connection = await dbTodo;
//     var result =
//         await connection.rawDelete("DELETE FROM $table WHERE id = $itemId");
//     return result;
//   }
// }



import 'package:sqflite/sqflite.dart';
import 'package:uas/repository/database_connection.dart';

class Repository {
  late DatabaseConnection _databaseConnection;
  static Database? _dbTodo;
  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  Future<Database> get dbTodo async {
    if (_dbTodo != null) {
      return _dbTodo!;
    } else {
      _dbTodo = await _databaseConnection.setDatabase();
      return _dbTodo!;
    }
  }

  insertData(table, data) async {
    var connection = await dbTodo;
    var result = connection.insert(table, data);
    return result;
  }

  readData(table) async {
    var connection = await dbTodo;
    var result = await connection.query(table);
    return result;
  }

  readDataById(table, itemId) async {
    var connection = await dbTodo;
    var result =
        await connection.query(table, where: 'id=?', whereArgs: [itemId]);
    return result;
  }

  updateData(table, data) async {
    var connection = await dbTodo;
    var result = await connection
        .update(table, data, where: 'id=?', whereArgs: [data['id']]);
    return result;
  }

  deleteData(table, itemId) async {
    var connection = await dbTodo;
    var result =
        await connection.rawDelete("DELETE FROM $table WHERE id = $itemId");
    return result;
  }

// ====================================

  insertCategory(data) async {
    return await insertData('categories', data);
  }

  readCategories() async {
    return await readData('categories');
  }

  readCategoryById(itemId) async {
    return await readDataById('categories', itemId);
  }

  updateCategory(data) async {
    return await updateData('categories', data);
  }

  deleteCategory(itemId) async {
    return await deleteData('categories', itemId);
  }
}

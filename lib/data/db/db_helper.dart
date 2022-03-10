import 'package:sqflite/sqflite.dart';
import 'package:todo_apps/data/db/todo_dao.dart';
import 'package:path/path.dart';

class DBHelper {

  DBHelper._privateConstructor();

  static DBHelper instance = DBHelper._privateConstructor();

  final tables = [
    TodoDao.CREATE_TABLE
  ];

  static Database? _database;

  Future<Database> openDB() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'todoapp.db'),
      onCreate: (db, version) {
        tables.forEach((table) async {
          await db.execute(table).then((_) => {
            print('$table create')
          }).catchError((onError) {
            print('error $onError');
          });
        });
      }, version: 1);
  }

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await openDB();
    return _database;
  }

  Future<int?> insert(String table, Map<String, dynamic> data) async {
    try {
      Database? db = await instance.database;
      final result = db?.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
      return result;
    } catch(e) {
      print('error: $e');
      return null;
    }
  }
}
abstract class TodoDao {
  static const String TABLE_NAME = 'todos_other';
  static const String CREATE_TABLE = 'CREATE TABLE IF NOT EXISTS $TABLE_NAME '
        '(id INT PRIMARY KEY AUTOINCREMENT, name TEXT)';
}
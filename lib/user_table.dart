class UserTable {
  static const String tableName = 'user';
  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnEmail = 'email';

  static const String createTableQuery = '''
    CREATE TABLE $tableName (
      $columnId TEXT PRIMARY KEY,
      $columnName TEXT,
      $columnEmail TEXT
    )
  ''';
}

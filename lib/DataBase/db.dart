import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    print("==================Database Init=======================");
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'user_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    print("==================creating db==================");
    try {
      await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        userId TEXT,
        password TEXT
      )
    ''');

      await db.execute('''
      CREATE TABLE dropdownValues (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        dropdowntype TEXT,
        value TEXT,
        dropdownIndex  INTEGER
      )
    ''');

      await db.execute('''
      CREATE TABLE Losses (
        lossType TEXT PRIMARY KEY
      )
    ''');

      await db.execute('''
      CREATE TABLE SubLosses (
        id INTEGER PRIMARY KEY,
        lossType TEXT,
        sublossName TEXT,
        FOREIGN KEY (lossType) REFERENCES Losses (lossType) ON DELETE CASCADE
      )
    ''');

      await db.execute('''
      CREATE TABLE dataTable ( 
        id INTEGER PRIMARY KEY,
        date TEXT,
        time TEXT,
        selectedPlant TEXT,
        selectedLine TEXT,
        selectedMachine TEXT,
        selectedUser TEXT,
        selectedShift TEXT,
        selectedOperator TEXT,
        selectedPNumber TEXT,
        selectedLoss TEXT,
        selectedSubLoss TEXT,
        selectedMinutes TEXT,
        selectedDefectQty TEXT,
        selectedNoOfSetups TEXT
      )
    ''');
      print('Tables created successfully');
    } catch (e) {
      print('Error creating tables: $e');
    }
  }

  // void addEnteries() async {
  //   DatabaseHelper databaseHelper = DatabaseHelper.instance;

  //   // Insert a dropdown value with auto-incrementing index
  //   await databaseHelper.insertDropdownValue('Plant', 'Plant 1');
  //   await databaseHelper.insertDropdownValue('Plant', 'Plant 2');
  //   await databaseHelper.insertDropdownValue('Plant', 'Plant 3');
  //   await databaseHelper.insertDropdownValue('Line', 'Line 1');
  //   await databaseHelper.insertDropdownValue('Line', 'Line 2');
  //   await databaseHelper.insertDropdownValue('Line', 'Line 3');
  //   await databaseHelper.insertDropdownValue('Machine', 'Machine 1');
  //   await databaseHelper.insertDropdownValue('Machine', 'Machine 2');
  //   await databaseHelper.insertDropdownValue('Machine', 'Machine 3');
  //   await databaseHelper.insertDropdownValue('Shift', 'Shift 1');
  //   await databaseHelper.insertDropdownValue('Shift', 'Shift 2');
  //   await databaseHelper.insertDropdownValue('Shift', 'Shift 3');
  //   await databaseHelper.insertDropdownValue('Operator', 'Operator 1');
  //   await databaseHelper.insertDropdownValue('Operator', 'Operator 2');
  //   await databaseHelper.insertDropdownValue('Operator', 'Operator 3');
  //   await databaseHelper.insertDropdownValue('P Number', 'P Number 1');
  //   await databaseHelper.insertDropdownValue('P Number', 'P Number 2');
  //   await databaseHelper.insertDropdownValue('P Number', 'P Number 3');
  // }

  Future<int> createUser(String name, String userId, String password) async {
    Database db = await instance.database;

    // Check if the user with the same userId already exists
    List<Map<String, dynamic>> existingUsers =
        await db.query('users', where: 'userId = ?', whereArgs: [userId]);

    if (existingUsers.isNotEmpty) {
      // User with the same userId already exists
      // You can handle this situation according to your app's requirements
      // For example, throw an exception, show an error message, etc.
      throw Exception('User with the same userId already exists');
    }

    // User with the same userId does not exist, proceed with the insertion
    return await db.insert(
        'users', {'name': name, 'userId': userId, 'password': password});
  }

  Future<Map<String, dynamic>?> authorizeLogin(
      String userId, String password) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query('users',
        where: 'userId = ? AND password = ?', whereArgs: [userId, password]);
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

//   Future<int> insertDropdownValue(String dropdownType, String value) async {
//     Database db = await instance.database;

//     // Get the maximum dropdownIndex for the given dropdownType
//     List<Map<String, dynamic>> maxIndexResult = await db.rawQuery('''
//    SELECT MAX(dropdownIndex) AS maxIndex FROM dropdownValues WHERE dropdowntype = ?
// ''', [dropdownType]);

//     int maxIndex = maxIndexResult.first['maxIndex'] ?? 0;
//     int newIndex = maxIndex + 1;

//     return await db.insert('dropdownValues', {
//       'dropdowntype': dropdownType,
//       'value': value,
//       'dropdownIndex': newIndex
//     });
//   }

  Future<void> addDropdownValues(
      List<Map<String, String>> dropdownValues) async {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;
    Database db = await databaseHelper.database;

    for (var value in dropdownValues) {
      String dropdownType = value['dropdownType']!;
      String dropdownValue = value['value']!;

      // Check if the dropdown value already exists
      List<Map<String, dynamic>> existingValues = await db.rawQuery('''
      SELECT * FROM dropdownValues WHERE dropdowntype = ? AND value = ?
    ''', [dropdownType, dropdownValue]);

      if (existingValues.isEmpty) {
        // Get the maximum dropdownIndex for the given dropdownType
        List<Map<String, dynamic>> maxIndexResult = await db.rawQuery('''
        SELECT MAX(dropdownIndex) AS maxIndex FROM dropdownValues WHERE dropdowntype = ?
      ''', [dropdownType]);

        int maxIndex = maxIndexResult.first['maxIndex'] ?? 0;
        int newIndex = maxIndex + 1;

        await db.insert('dropdownValues', {
          'dropdowntype': dropdownType,
          'value': dropdownValue,
          'dropdownIndex': newIndex,
        });
      }
    }
  }

  Future<List<Map<String, dynamic>>> getDropdownValuesByType(
      String dropdownType) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query(
      'dropdownValues',
      where: 'dropdowntype = ?',
      whereArgs: [dropdownType],
      orderBy: 'dropdownIndex ASC',
    );
    return results;
  }

  Future<void> deleteDropdownValue(String dropdownType, String value) async {
    Database db = await instance.database;
    await db.delete('dropdownValues',
        where: 'dropdowntype = ? AND value = ?',
        whereArgs: [dropdownType, value]);

    await db.rawQuery('''
   UPDATE dropdownValues SET dropdownIndex = dropdownIndex - 1 WHERE dropdowntype = ? AND value = ?
''', [dropdownType, value]);
  }

  Future<List<String>> getAllSubLosses(String lossType) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      'SubLosses',
      where: 'lossType = ?',
      whereArgs: [lossType],
    );

    List<String> sublosses = [];
    for (Map<String, dynamic> row in result) {
      sublosses.add(row['sublossName']);
    }

    return sublosses;
  }

  Future<void> deleteSubLoss(String loss, String sublossName) async {
    Database db = await instance.database;
    await db.delete(
      'SubLosses',
      where: 'lossType = ? AND sublossName = ?',
      whereArgs: [loss, sublossName],
    );
  }

  Future<void> addAllSubLosses(Map<String, List<String>> lossSubLossMap) async {
    Database db = await instance.database;

    // Use a transaction to ensure atomicity
    await db.transaction((txn) async {
      for (var entry in lossSubLossMap.entries) {
        String lossType = entry.key;
        List<String> sublosses = entry.value;

        for (String sublossName in sublosses) {
          // Check if the combination of lossType and sublossName already exists
          int? count = Sqflite.firstIntValue(await txn.rawQuery(
            'SELECT COUNT(*) FROM SubLosses WHERE lossType = ? AND sublossName = ?',
            [lossType, sublossName],
          ));

          // If the count is 0, insert the new record
          if (count == 0) {
            await txn.insert(
              'SubLosses',
              {'lossType': lossType, 'sublossName': sublossName},
            );
          }
          // If count is greater than 0, the record already exists, so you can handle it as needed (e.g., log a message)
          else {
            print(
                'Record already exists for lossType: $lossType, sublossName: $sublossName');
          }
        }
      }
    });
  }

  Future<int> insertUserData(Map<String, dynamic> row) async {
    print(row);
    print("Inserting Data into DataBase");
    Database db = await instance.database;
    return await db.insert("dataTable", row);
  }

  Future<List<Map<String, dynamic>>> getDataByDateRange(
      String startDate, String endDate) async {
    Database db = await instance.database;
    return await db.query(
      "dataTable",
      where: 'date BETWEEN ? AND ?',
      whereArgs: [startDate, endDate],
    );
  }

  Future<int> deleteDataByDateRange(String fromDate, String toDate) async {
    Database db = await instance.database;
    return await db.delete(
      "dataTable",
      where: 'date BETWEEN ? AND ?',
      whereArgs: [fromDate, toDate],
    );
  }
}

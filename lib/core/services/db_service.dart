import 'dart:io';
import 'package:meter_reading/core/models/meter_model.dart';
import 'package:meter_reading/core/models/reading_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseManager {
  static final _dbName = "Database.db";

  // Use this class as a singleton
  DatabaseManager._privateConstructor();
  static final DatabaseManager instance = DatabaseManager._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // Instantiate the database only when it's not been initialized yet.
    _database = await _initDatabase();
    return _database;
  }

  // Creates and opens the database.
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Creates the database structure
  Future _onCreate(
    Database db,
    int version,
  ) async {
    //Date is Stored as time in seconds
    await db.execute('''
          CREATE TABLE Meter (
            id INTEGER PRIMARY KEY,
            name TEXT,
            serialNumber TEXT,
            installationDate INTEGER,
            outOfServiceDate INTEGER
          )
          ''');

    await db.execute('''
          CREATE TABLE MeterReading (
            id INTEGER PRIMARY KEY,
            meterId INTEGER,
            date INTEGER,
            reading INTEGER,
            latitude REAL,
            longitude REAL,
            image TEXT
          )
          ''');
  }

  Future<List<MeterReading>> fetchAllMeterReading() async {
    List<Map<String, dynamic>> maps =
        await (await database).query('MeterReading');
    if (maps.isNotEmpty) {
      return maps.map((map) => MeterReading.fromMap(map)).toList();
    }
    return null;
  }

  Future<MeterReading> fetchMeterReading(int meterId) async {
    List<Map<String, dynamic>> maps = await (await database).query(
      'MeterReading',
      where: 'meterId = ?',
      whereArgs: [meterId],
      orderBy: 'date DESC'
    );
    if (maps.isNotEmpty) {
      return maps.map((map) => MeterReading.fromMap(map)).toList()?.first;
    }
    return null;
  }

  Future<int> addMeterReading(MeterReading meterReading) async {
    return (await database).insert(
      'MeterReading',
      meterReading.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Meter>> fetchAllMeter() async {
    List<Map<String, dynamic>> maps = await (await database).query('Meter');
    if (maps.isNotEmpty) {
      return maps.map((map) => Meter.fromMap(map)).toList();
    }
    return null;
  }

  Future<int> addMeter(Meter meter) async {
    return (await database).insert(
      'Meter',
      meter.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

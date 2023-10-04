import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'journey.dart';
import 'journey_point.dart';

class DBService {
  static const String dbName = 'journey.db';

  Future<Database>? _database;

  void initialise() async {
    _database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), dbName),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        db.execute(
            'CREATE TABLE IF NOT EXISTS journey_point(id INTEGER PRIMARY KEY, journey INTEGER, position TEXT);');
        db.execute(
            'CREATE TABLE IF NOT EXISTS journey(id INTEGER PRIMARY KEY, journey_type INTEGER, start_time INTEGER, end_time INTEGER);');
        return;
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  Future<Database>? database() {
    return _database;
  }

  Future<void> insertJourneyPoint(JourneyPoint journeyPoint) async {
    // Get a reference to the database.
    final db = await _database!;

    // Insert the Data into the correct table.
    await db.insert(
      'journey_point',
      journeyPoint.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertJourney(Journey journey) async {
    // Get a reference to the database.
    final db = await _database!;

    // Insert the Data into the correct table.
    await db.insert(
      'journey',
      journey.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<JourneyPoint>> getJourneyPoints(int journey) async {
    final db = await _database;

    // Fetch journey points for stated journey id.
    String whereString = 'journey = ?';
    List<dynamic> whereArguments = [journey];
    final List<Map<String, dynamic>> maps = await db!
        .query('journey_point', where: whereString, whereArgs: whereArguments);

    // Convert the List<Map<String, dynamic> into a List<Location>.
    return List.generate(maps.length, (i) {
      String posStr = maps[i]['position'];
      Map<dynamic, dynamic> posMap = json.decode(posStr);
      Position position = Position.fromMap(posMap);

      return JourneyPoint(
        id: maps[i]['id'],
        journey: maps[i]['journey'],
        position: position,
      );
    });
  }

  Future<List<Journey>> getJourneys() async {
    final db = await _database;

    final List<Map<String, dynamic>> maps = await db!.query('journey');

    // Convert the List<Map<String, dynamic> into a List<Location>.
    return List.generate(maps.length, (i) {
      return Journey(
        id: maps[i]['id'],
        journeyType: maps[i]['journeyType'],
        startTime: maps[i]['startTime'],
        endTime: maps[i]['endTime'],
      );
    });
  }

  Future<void> deleteAll() async {
    // Get a reference to the database.
    final db = await _database;

    try {
      // Remove the Dog from the database.
      await db.delete("journey");
      await db.delete('journey_points');
    }
    catch(Exception e)
    {

    }

  }
}

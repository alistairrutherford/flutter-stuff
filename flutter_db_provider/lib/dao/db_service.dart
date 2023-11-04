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
            'CREATE TABLE IF NOT EXISTS journey_point(id INTEGER PRIMARY KEY, '
            'journey INTEGER, '
            'latitude REAL, '
            'longitude REAL, '
            'timestamp INTEGER, '
            'altitude REAL, '
            'altitudeAccuracy REAL, '
            'accuracy REAL, '
            'heading REAL, '
            'headingAccuracy REAL, '
            'speed REAL, '
            'speedAccuracy REAL);');
        db.execute('CREATE TABLE IF NOT EXISTS journey(id INTEGER PRIMARY KEY, '
            'journey_type INTEGER, '
            'start_time INTEGER, '
            'end_time INTEGER, '
            'distance REAL);');
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

  Future<int> insertJourney(Journey journey) async {
    // Get a reference to the database.
    final db = await _database!;

    int id = -1;

    try {
      // Insert the Data into the correct table.
      id = await db.insert(
        'journey',
        journey.toMap(),
      );
    } catch (e) {
      print(e);
    }

    return id;
  }

  Future<int> updateJourney(Journey journey) async {
    // Get a reference to the database.
    final db = await _database!;

    // Update the Data into the correct table.
    int updateCount = await db.update('journey', journey.toMap(),
        where: "id = ?", whereArgs: [journey.id]);

    return updateCount;
  }

  Future<void> insertJourneyPoint(JourneyPoint journeyPoint) async {
    // Get a reference to the database.
    final db = await _database!;

    // Insert the Data into the correct table.
    await db.insert(
      'journey_point',
      journeyPoint.toMap(),
    );
  }

  Future<Journey> getJourney(int id) async {
    final db = await _database;

    String whereString = 'id = ?';
    List<dynamic> whereArguments = [id];
    final List<Map<String, dynamic>> maps = await db!
        .query('journey', where: whereString, whereArgs: whereArguments);

    DateTime? endTime;
    int? endTimeValue = maps[0]['end_time'];
    if (endTimeValue != null) {
      endTime = DateTime.fromMillisecondsSinceEpoch(endTimeValue);
    }
    return Journey(
      id: maps[0]['id'],
      journeyType: JourneyType.values[maps[0]['journey_type']],
      startTime: DateTime.fromMillisecondsSinceEpoch(maps[0]['start_time']),
      endTime: endTime,
    );
  }

  Future<List<Journey>> getJourneys() async {
    final db = await _database;

    final List<Map<String, dynamic>> maps = await db!.query('journey');

    // Convert the List<Map<String, dynamic> into a List<Location>.
    return List.generate(maps.length, (i) {
      DateTime? endTime;
      int? endTimeValue = maps[0]['end_time'];
      if (endTimeValue != null) {
        endTime = DateTime.fromMillisecondsSinceEpoch(endTimeValue);
      }

      return Journey(
        id: maps[i]['id'],
        journeyType: JourneyType.values[maps[i]['journey_type']],
        startTime: DateTime.fromMillisecondsSinceEpoch(maps[i]['start_time']),
        endTime: endTime,
      );
    });
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

      return JourneyPoint(
          id: maps[i]['id'],
          journey: maps[i]['journey'],
          latitude: maps[i]['latitude'],
          longitude: maps[i]['longitude'],
          timestamp: maps[i]['timestamp'],
          accuracy: maps[i]['accuracy'],
          altitude: maps[i]['altitude'],
          altitudeAccuracy: maps[i]['altitudeAccuracy'],
          heading: maps[i]['heading'],
          headingAccuracy: maps[i]['headingAccuracy'],
          speed: maps[i]['speed'],
          speedAccuracy: maps[i]['speedAccuracy']);
    });
  }

  Future<void> deleteAll() async {
    // Get a reference to the database.
    final db = await _database;

    try {
      // Remove the data from the database.
      await db?.delete("journey");
      await db?.delete('journey_point');
    } on Exception {
      print('Error');
    }
  }
}

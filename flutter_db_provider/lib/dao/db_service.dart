import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'journey.dart';
import 'journey_point.dart';

/// Database Service.
///
/// To access data
/// - >>adb shell
/// - >>run-as com.example.flutter_db_provider
///
class DBService {
  static const String dbName = 'journey.db';
  Future<Database>? _database;
  Function? onInit;

  /// Initialise the database.
  void initialise(Function onInit) async {
    this.onInit = onInit;

    _database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), dbName),
      // When the database is first created, create tables.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        db.execute(
            'CREATE TABLE IF NOT EXISTS journey_point(id INTEGER PRIMARY KEY, '
            'journey INTEGER, '
            'latitude REAL, '
            'longitude REAL, '
            'timestamp INTEGER, '
            'accuracy REAL, '
            'altitude REAL, '
            'altitudeAccuracy REAL, '
            'heading REAL, '
            'headingAccuracy REAL, '
            'speed REAL, '
            'speedAccuracy REAL);');
        db.execute('CREATE TABLE IF NOT EXISTS journey(id INTEGER PRIMARY KEY, '
            'journey_type INTEGER, '
            'start_time INTEGER, '
            'end_time INTEGER, '
            'duration INTEGER, '
            'distance REAL,'
            'uploaded INTEGER);');

        return;
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    // Call initialisation callback to perform first op on
    onInit();
  }

  /// Get database reference.
  ///
  Future<Database>? database() {
    return _database;
  }

  /// Insert new Journey into DB.
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
      stderr.writeln(e);
    }

    return id;
  }

  /// Update Journey
  ///
  Future<int> updateJourney(Journey journey) async {
    // Get a reference to the database.
    final db = await _database!;

    // Calculate and save duration if possible.
    if (journey.endTime != null) {
      Duration duration = journey.endTime!.difference(journey.startTime);
      journey.duration = duration.inSeconds;
    }

    // Update the Data into the correct table.
    int updateCount = await db.update('journey', journey.toMap(),
        where: "id = ?", whereArgs: [journey.id]);

    return updateCount;
  }

  /// Update Journey
  ///
  Future<int> delete(Journey journey) async {
    // Get a reference to the database.
    final db = await _database!;

    // Delete associated journey points.
    int updateCount = await db
        .delete('journey_point', where: "journey = ?", whereArgs: [journey.id]);

    // Delete journey
    updateCount +=
        await db.delete('journey', where: "id = ?", whereArgs: [journey.id]);

    return updateCount;
  }

  /// Insert Journey Point.
  ///
  Future<void> insertJourneyPoint(JourneyPoint journeyPoint) async {
    // Get a reference to the database.
    final db = await _database!;

    // Insert the Data into the correct table.
    await db.insert(
      'journey_point',
      journeyPoint.toMap(),
    );
  }

  /// Build a Journey from field map.
  ///
  Journey buildJourneyFromMap(Map<String, dynamic> map) {
    DateTime? endTime;
    int? endTimeValue = map['end_time'];
    if (endTimeValue != null) {
      endTime = DateTime.fromMillisecondsSinceEpoch(endTimeValue);
    }
    return Journey(
        id: map['id'],
        journeyType: JourneyType.values[map['journey_type']],
        startTime: DateTime.fromMillisecondsSinceEpoch(map['start_time']),
        endTime: endTime,
        duration: map['duration'],
        distance: map['distance'],
        uploaded: map['uploaded'] == 1 ? true : false);
  }

  /// Get Journey by id.
  ///
  Future<Journey> getJourney(int id) async {
    final db = await _database;

    String whereString = 'id = ?';
    List<dynamic> whereArguments = [id];
    final List<Map<String, dynamic>> maps = await db!
        .query('journey', where: whereString, whereArgs: whereArguments);

    return buildJourneyFromMap(maps[0]);
  }

  /// Get all Journeys.
  ///
  Future<List<Journey>> getJourneys() async {
    final db = await _database;

    final List<Map<String, dynamic>> maps = await db!.query('journey');

    // Convert the List<Map<String, dynamic> into a List<Location>.
    return List.generate(maps.length, (i) {
      return buildJourneyFromMap(maps[i]);
    });
  }

  /// Get all Journey related points by Journey id.
  ///
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
          timestamp: DateTime.fromMillisecondsSinceEpoch(maps[i]['timestamp']),
          accuracy: maps[i]['accuracy'],
          altitude: maps[i]['altitude'],
          altitudeAccuracy: maps[i]['altitudeAccuracy'],
          heading: maps[i]['heading'],
          headingAccuracy: maps[i]['headingAccuracy'],
          speed: maps[i]['speed'],
          speedAccuracy: maps[i]['speedAccuracy']);
    });
  }

  /// Delete All data.
  ///
  Future<void> deleteAll() async {
    // Get a reference to the database.
    final db = await _database;

    try {
      // Remove the data from the database.
      await db?.delete("journey");
      await db?.delete('journey_point');
    } catch (e) {
      stderr.writeln(e);
    }
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_db_provider/dao/journey.dart';
import 'package:flutter_db_provider/journey_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';

class LocationModel extends ChangeNotifier {
  static const int defaultDistanceFilter = 0;

  late LocationSettings locationSettings;
  StreamSubscription<Position>? positionStream;
  Position? currentPosition;

  LocationModel() {
    // Initialise.
    initialise();
    // Get current with callback.
    determineCurrentPosition();
  }

  void initialise() async {
    initialiseLocationSettings();

    currentPosition = await Geolocator.getLastKnownPosition();
  }

  void determineCurrentPosition() {
    determinePosition().then((c) {
      currentPosition = c;
      // Once determined notify listeners.
      notifyListeners();
    });
  }

  void updateCurrentPosition(Position? position) {
    currentPosition = position;
    // Once updated notify listeners.
    notifyListeners();
  }

  void initialiseLocationSettings() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 2,
        intervalDuration: const Duration(seconds: 5),
        forceLocationManager: false,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: defaultDistanceFilter,
        pauseLocationUpdatesAutomatically: true,
        // Only set to true if our app will be started up in the background.
        showBackgroundLocationIndicator: false,
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
      );
    }
  }

  void startPositionStream(Journey? journey, JourneyModel journeyModel) {
    if (journey != null) {
      positionStream =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((Position? position) {
        updateCurrentPosition(position);
        journeyModel.addJourneyPoint(journey, position!);
      });
    }
  }

  void endPositionStream() async {
    if (positionStream != null) {
      await positionStream!.cancel();
    }
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        await Geolocator.openAppSettings();
        await Geolocator.openLocationSettings();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}

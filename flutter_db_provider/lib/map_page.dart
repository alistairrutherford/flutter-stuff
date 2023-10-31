import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'location_model.dart';

class MapPage extends StatelessWidget {
  final MapController _mapController = MapController();

  MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    const double defaultZoom = 17;

    var locationModel = context.watch<LocationModel>();

    // Determine current location (if any).
    LatLng latLng =  (locationModel.currentPosition != null)
        ? (LatLng(locationModel.currentPosition!.latitude,
        locationModel.currentPosition!.longitude))
        : (const LatLng(51.5072, 0.1276));

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: latLng,
        initialZoom: defaultZoom,
        onMapEvent: (e) {
          _mapController.move(latLng, defaultZoom);
        },
        onMapReady: () {
          _mapController.move(latLng, defaultZoom);
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () =>
                  launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
            ),
          ],
        ),
      ],
    );
  }
}

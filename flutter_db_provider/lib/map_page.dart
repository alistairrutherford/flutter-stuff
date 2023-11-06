import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'location_model.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const double defaultZoom = 17;
  final MapController _mapController = MapController();
  Marker? _marker;
  LatLng? _latLng;
  bool _mapReady = false;

  void updateView(LocationModel locationModel) {
    // Determine current location (if any).
    _latLng = (locationModel.currentPosition != null)
        ? (LatLng(locationModel.currentPosition!.latitude,
        locationModel.currentPosition!.longitude))
        : (const LatLng(51.5072, 0.1276));

    _marker = Marker(
      width: 10,
      height: 10,
      point: _latLng!,
      child: const Icon(Icons.location_history_rounded ),
      alignment: const Alignment(0,-2.5)
    );

    if (_mapReady) {
      _mapController.move(_latLng!, defaultZoom);
    }
  }

  @override
  Widget build(BuildContext context) {
    var locationModel = context.watch<LocationModel>();

    // Every time the model notifies a change the view will update.
    updateView(locationModel);

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialZoom: defaultZoom,
        initialCenter: _latLng!,
        onMapReady: () {
          _mapReady = true;
        }
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(markers: [_marker!]),
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

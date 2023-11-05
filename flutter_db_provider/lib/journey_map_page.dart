import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'journey_model.dart';

class JourneyMapPage extends StatefulWidget {
  final int journeyId;
  const JourneyMapPage({super.key, required this.journeyId});

  @override
  State<JourneyMapPage> createState() => JourneyMapPageState();
}

class JourneyMapPageState extends State<JourneyMapPage> {
  static const double defaultZoom = 5;
  final MapController _mapController = MapController();
  final List<Polyline> _polyLines = List.empty(growable: true);

  void drawJourney(JourneyModel journeyModel) {
    List<LatLng>? points;

    journeyModel.getJourneyPoints(widget.journeyId).then((c) {
      points = c;

      if (points != null && points!.isNotEmpty) {
        // Build polyline.
        Polyline polyline = Polyline(points: points!, strokeWidth: 10);

        // Get bounds and fit view to bounds.
        LatLngBounds bounds = polyline.boundingBox;
        _mapController.fitCamera(CameraFit.bounds(bounds: bounds));

        // Update view with polyline
        setState(() {
          _polyLines.add(polyline);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var journeyModel = context.watch<JourneyModel>();

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
          initialZoom: defaultZoom,
          onMapReady: () {
            drawJourney(journeyModel);
          }
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        PolylineLayer(polylines: _polyLines),
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
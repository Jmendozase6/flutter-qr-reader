import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:qr_reader/models/scan_model.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition puntoInicial =
        CameraPosition(target: scan.getLatLng(), zoom: 17, tilt: 20);

    // Marcadores
    Set<Marker> markers = <Marker>{};
    markers.add(Marker(
        markerId: const MarkerId('geo-location'), position: scan.getLatLng()));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coordenadas - Mapa'),
        actions: [
          IconButton(
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(CameraPosition(
                    target: scan.getLatLng(), zoom: 17, tilt: 20)),
              );
            },
            icon: const Icon(Icons.location_disabled, color: Colors.white),
          )
        ],
      ),
      body: GoogleMap(
        markers: markers,
        mapType: mapType,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.layers),
        onPressed: () {
          setState(() {
            if (mapType == MapType.normal) {
              mapType = MapType.satellite;
            } else if (mapType == MapType.satellite) {
              mapType = MapType.terrain;
            } else {
              mapType = MapType.normal;
            }
          });
        },
      ),
    );
  }
}

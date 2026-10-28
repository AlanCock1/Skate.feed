
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  static const LatLng _initialPosition = LatLng(
    20.6089,
    -103.4125,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SKATE.FEED - Mapa'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: _initialPosition,
          zoom: 13,
        ),
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
        markers: const {},
      
      ),
    );
  }
}

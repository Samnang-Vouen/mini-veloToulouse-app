import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(43.6047, 1.4442),
          initialZoom: 14,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.velotoulouse',
          ),

          MarkerLayer(
            markers: [
              _buildMarker(43.6047, 1.4442),
              _buildMarker(43.6082, 1.4416),
              _buildMarker(43.5995, 1.4445),
              _buildMarker(43.6113, 1.4545),
              _buildMarker(43.6001, 1.4380),
              _buildMarker(43.6070, 1.4510),
              _buildMarker(43.5960, 1.4500),
            ],
          ),
        ],
      ),
    );
  }

  Marker _buildMarker(double lat, double lng) {
    return Marker(
      point: LatLng(lat, lng),
      width: 30,
      height: 30,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
      ),
    );
  }
}

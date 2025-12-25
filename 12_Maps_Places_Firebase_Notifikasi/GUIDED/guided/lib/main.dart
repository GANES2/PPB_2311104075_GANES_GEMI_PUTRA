import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

void main() {
  // Hybrid Composition (Android) agar render GoogleMap lebih stabil
  final GoogleMapsFlutterPlatform mapsImplementation = GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapsScreen(),
    );
  }
}

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  // Lokasi default (sesuai contoh modul: LatLng(19.018..., 72.847...))
  static const LatLng _kMapCenter = LatLng(19.018255973653343, 72.84793849278007);

  static const CameraPosition _kInitialPosition = CameraPosition(
    target: _kMapCenter,
    zoom: 11.0,
  );

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId("marker_1"),
      position: _kMapCenter,
      infoWindow: InfoWindow(title: "Marker 1"),
      rotation: 90,
    ),
    const Marker(
      markerId: MarkerId("marker_2"),
      position: LatLng(-6.9733165, 107.6281415),
      infoWindow: InfoWindow(title: "Marker 2"),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Maps Demo')),
      body: GoogleMap(
        initialCameraPosition: _kInitialPosition,
        myLocationEnabled: true, // menampilkan lokasi pengguna (jika permission sudah)
        myLocationButtonEnabled: true,
        markers: _markers,
      ),
    );
  }
}

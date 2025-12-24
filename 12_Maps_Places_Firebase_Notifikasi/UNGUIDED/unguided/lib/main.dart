import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker_google/place_picker_google.dart';

// Optional: Hybrid Composition (sering bantu biar map stabil di Android)
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

void main() {
  // Hybrid Composition (optional)
  final GoogleMapsFlutterPlatform mapsImpl = GoogleMapsFlutterPlatform.instance;
  if (mapsImpl is GoogleMapsFlutterAndroid) {
    mapsImpl.useAndroidViewSurface = true;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapsHomePage(),
    );
  }
}

class MapsHomePage extends StatefulWidget {
  const MapsHomePage({super.key});

  @override
  State<MapsHomePage> createState() => _MapsHomePageState();
}

class _MapsHomePageState extends State<MapsHomePage> {
  // ✅ GANTI INI
  static const String apiKey = "AIzaSyAlo-EOPFCIs5lN6ixqlnNBGe1M4BjIzVk";

  // Default posisi awal (boleh ganti)
  static const LatLng kMapCenter = LatLng(-6.9733165, 107.6281415);
  static const CameraPosition kInitialPosition =
      CameraPosition(target: kMapCenter, zoom: 14);

  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  String pickedName = "-";
  String pickedAddress = "-";
  LatLng? pickedLatLng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unguided: Maps + Place Picker"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: kInitialPosition,
              onMapCreated: (c) => _mapController = c,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: _markers,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hasil lokasi terpilih:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text("Nama/Label : $pickedName"),
                Text("Alamat     : $pickedAddress"),
                Text(
                  "Koordinat  : ${pickedLatLng == null ? '-' : '${pickedLatLng!.latitude}, ${pickedLatLng!.longitude}'}",
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => openPlacePicker(context),
                    icon: const Icon(Icons.place),
                    label: const Text("Pick Place"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> openPlacePicker(BuildContext context) async {
    final LocationResult? result =
        await Navigator.of(context).push<LocationResult>(
      MaterialPageRoute(
        builder: (_) => PlacePicker(
          apiKey: apiKey,
          initialLocation: pickedLatLng ?? kMapCenter,
        ),
      ),
    );

    if (result == null) return;

    final latLng = result.latLng;
    if (latLng == null) return;

    setState(() {
      pickedLatLng = LatLng(latLng.latitude, latLng.longitude);
      pickedName = result.name ?? "Unnamed location";
      pickedAddress = result.formattedAddress ?? "Alamat tidak tersedia";

      _markers
        ..clear()
        ..add(
          Marker(
            markerId: const MarkerId("picked_place"),
            position: pickedLatLng!,
            infoWindow: InfoWindow(
              title: pickedName,
              snippet: pickedAddress,
            ),
          ),
        );
    });

    await _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(pickedLatLng!, 16),
    );
  }
}

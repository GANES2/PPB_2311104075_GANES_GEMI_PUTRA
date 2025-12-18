import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker_google/place_picker_google.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maps & Place Picker',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
      ),
      home: const MapsHomePage(),
    );
  }
}

class MapsHomePage extends StatefulWidget {
  const MapsHomePage({super.key});

  @override
  State<MapsHomePage> createState() => _MapsHomePageState();
}

class _MapsHomePageState extends State<MapsHomePage> {
  static const String googleApiKey = "YOUR_KEY_HERE";

  // Kamu bebas ganti koordinat default (misal kampus/rumah)
  static const LatLng kMapCenter = LatLng(-7.4350827, 109.2492682);
  static const CameraPosition kInitialPosition = CameraPosition(
    target: kMapCenter,
    zoom: 15,
  );

  GoogleMapController? _mapController;

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId("marker_default"),
      position: kMapCenter,
      infoWindow: InfoWindow(title: "Default Marker", snippet: "Lokasi awal aplikasi"),
    ),
  };

  LocationResult? _picked;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<void> _openPlacePicker() async {
    // Navigasi ke halaman place picker, ambil result baliknya
    final result = await Navigator.of(context).push<LocationResult?>(
      MaterialPageRoute(
        builder: (_) => const PickPlacePage(apiKey: googleApiKey),
      ),
    );

    if (result == null) return;

    setState(() => _picked = result);

    final lat = result.latLng?.latitude;
    final lng = result.latLng?.longitude;

    if (lat != null && lng != null) {
      final pos = LatLng(lat, lng);

      setState(() {
        _markers.removeWhere((m) => m.markerId.value == "picked_place");
        _markers.add(
          Marker(
            markerId: const MarkerId("picked_place"),
            position: pos,
            infoWindow: InfoWindow(
              title: result.name ?? "Picked Place",
              snippet: result.formattedAddress ?? "",
            ),
          ),
        );
      });

      await _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: pos, zoom: 17)),
      );

      if (mounted) {
        _showPickedBottomSheet(result);
      }
    }
  }

  void _showPickedBottomSheet(LocationResult result) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (ctx) {
        final name = result.name ?? "-";
        final address = result.formattedAddress ?? "-";
        final lat = result.latLng?.latitude;
        final lng = result.latLng?.longitude;
        final coords = (lat != null && lng != null) ? "$lat, $lng" : "-";

        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16 + MediaQuery.of(ctx).padding.bottom,
            top: 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Hasil Place Picker",
                style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 12),
              _InfoTile(label: "Nama Tempat", value: name),
              const SizedBox(height: 8),
              _InfoTile(label: "Alamat", value: address),
              const SizedBox(height: 8),
              _InfoTile(label: "Koordinat", value: coords),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: coords == "-" ? null : () async {
                  await Clipboard.setData(ClipboardData(text: coords));
                  if (ctx.mounted) {
                    ScaffoldMessenger.of(ctx).showSnackBar(
                      const SnackBar(content: Text("Koordinat disalin ke clipboard ✅")),
                    );
                  }
                },
                icon: const Icon(Icons.copy),
                label: const Text("Copy Koordinat"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final pickedText = (_picked?.name != null)
        ? "Terpilih: ${_picked!.name}"
        : "Belum memilih lokasi";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Maps + Place Picker"),
        actions: [
          IconButton(
            tooltip: "Pick Place",
            onPressed: _openPlacePicker,
            icon: const Icon(Icons.place_outlined),
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: kInitialPosition,
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: _markers,
            onTap: (latLng) {
              // Bonus: tap map bikin marker sementara
              setState(() {
                _markers.removeWhere((m) => m.markerId.value == "tap_marker");
                _markers.add(
                  Marker(
                    markerId: const MarkerId("tap_marker"),
                    position: latLng,
                    infoWindow: InfoWindow(
                      title: "Tap Marker",
                      snippet: "${latLng.latitude}, ${latLng.longitude}",
                    ),
                  ),
                );
              });
            },
          ),

          // Banner status kecil (biar ga polos)
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        pickedText,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: _openPlacePicker,
                      child: const Text("Pick Place"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PickPlacePage extends StatelessWidget {
  final String apiKey;
  const PickPlacePage({super.key, required this.apiKey});

  static const LatLng kInitial = LatLng(-7.4350827, 109.2492682);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Place Picker")),
      body: PlacePicker(
        apiKey: apiKey,
        initialLocation: kInitial,
        onPlacePicked: (result) {
          Navigator.of(context).pop(result);
        },
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: t.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: t.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(value, style: t.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

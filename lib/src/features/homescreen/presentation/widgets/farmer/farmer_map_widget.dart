import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tractorapp/src/core/constants/colors.dart';

class FarmerMapWidget extends StatefulWidget {
  const FarmerMapWidget({super.key});

  @override
  State<FarmerMapWidget> createState() => _FarmerMapWidgetState();
}

class _FarmerMapWidgetState extends State<FarmerMapWidget> {
  late GoogleMapController _mapController;

  final List<LatLng> _polygonCoords = const [
    LatLng(-6.7924, 39.2083), // Example coordinates (Dar es Salaam)
    LatLng(-6.7920, 39.2180),
    LatLng(-6.8000, 39.2150),
    LatLng(-6.8005, 39.2100),
  ];

  final LatLng _center = const LatLng(-6.7960, 39.2130);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 15.0,
          ),
          onMapCreated: (controller) => _mapController = controller,
          polygons: {
            Polygon(
              polygonId: const PolygonId('area'),
              points: _polygonCoords,
              fillColor: AppColors.primaryGreen.withValues(alpha: 0.1),
              strokeColor: AppColors.primaryGreen,
              strokeWidth: 2,
            ),
          },
          markers: _polygonCoords
              .map((coord) => Marker(
                    markerId: MarkerId(coord.toString()),
                    position: coord,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen),
                  ))
              .toSet(),
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          scrollGesturesEnabled: true,
          tiltGesturesEnabled: false,
          rotateGesturesEnabled: false,
        ),
      ),
    );
  }
}

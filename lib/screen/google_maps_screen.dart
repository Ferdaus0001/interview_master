import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({super.key});

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  GoogleMapController? mapController;

  // Cluster Manager
  final Set<ClusterManager> clusterManagers = {
    ClusterManager(
      clusterManagerId: const ClusterManagerId('places'),
    ),
  };

  // Markers
  final Set<Marker> markers = {
    Marker(
      markerId: const MarkerId('1'),
      position: const LatLng(23.8103, 90.4125),
      clusterManagerId: const ClusterManagerId('places'),
    ),
    Marker(
      markerId: const MarkerId('2'),
      position: const LatLng(23.8110, 90.4130),
      clusterManagerId: const ClusterManagerId('places'),
    ),
    Marker(
      markerId: const MarkerId('3'),
      position: const LatLng(23.8120, 90.4140),
      clusterManagerId: const ClusterManagerId('places'),
    ),
    Marker(
      markerId: const MarkerId('4'),
      position: const LatLng(23.8130, 90.4150),
      clusterManagerId: const ClusterManagerId('places'),
    ),
  };

  // Heatmaps
// Heatmaps
  final Set<Heatmap> heatmaps = {
    Heatmap(
      heatmapId: const HeatmapId('users_heatmap'),
      data: const [
        WeightedLatLng(
          LatLng(23.8103, 90.4125),
          weight: 5,
        ),
        WeightedLatLng(
          LatLng(23.8110, 90.4130),
          weight: 10,
        ),
        WeightedLatLng(
          LatLng(23.8120, 90.4140),
          weight: 20,
        ),
        WeightedLatLng(
          LatLng(23.8130, 90.4150),
          weight: 30,
        ),
        WeightedLatLng(
          LatLng(23.8140, 90.4160),
          weight: 40,
        ),
      ],
      radius: const HeatmapRadius.fromPixels(50),
      opacity: 0.7,
    ),
  };
  Future<void> getCurrenLocatosn() async {
    bool serviceEnabled =
    await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission =
    await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    Position position =
    await Geolocator.getCurrentPosition();

    print('Lon: ${position.longitude}');
    print('Lat: ${position.latitude}');

    mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(
          position.latitude,
          position.longitude,
        ),
        16,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    getCurrenLocatosn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        rotateGesturesEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;

          getCurrenLocatosn();
        },

        // Initial camera
        initialCameraPosition: const CameraPosition(
          target: LatLng(0, 0),
          zoom: 2,
        ),

        // Location
        myLocationEnabled: true,
        myLocationButtonEnabled: true,

        // Zoom
        zoomControlsEnabled: true,

        // Compass
        compassEnabled: true,

        // Buildings
        buildingsEnabled: true,

        // 45 degree imagery
        fortyFiveDegreeImageryEnabled: true,

        // Map style
        style: '''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#1d2c3b"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8fa3b8"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1d2c3b"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#405465"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#34495e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#263746"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#b8c7d6"
      }
    ]
  },
  {
    "featureType": "poi",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#102331"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#58758c"
      }
    ]
  }
]
''',

        // Map padding
        padding: const EdgeInsets.only(
          top: 100,
          bottom: 50,
        ),

        // Gesture handling
        gestureRecognizers:
        <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
          ),
        },

        // Camera bounds
        cameraTargetBounds: CameraTargetBounds(
          LatLngBounds(
            southwest: const LatLng(23.5, 90.2),
            northeast: const LatLng(24.0, 90.6),
          ),
        ),
        indoorViewEnabled: true,
        // Cluster managers
        clusterManagers: clusterManagers,
        // liteModeEnabled:true,
        markerType: GoogleMapMarkerType.advancedMarker,


        // Heatmaps
        heatmaps: heatmaps,
        layoutDirection: TextDirection.rtl,
        // Markers
        markers: markers,
      ),
    );
  }
}
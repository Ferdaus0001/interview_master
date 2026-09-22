import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({super.key});

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}



 final double lat = 23.8103;
final  double lon = 90.4125;
Set<Polygon> polygon = {
  Polygon(
    polygonId: PolygonId('ara'),
    points: [
      LatLng(23.8103, 90.4125), // A
      LatLng(23.8203, 90.4225), // B
      LatLng(23.8003, 90.4325), // C
      LatLng(23.7903, 90.4125), // D
    ],
    strokeWidth: 3,
    fillColor: Colors.blue,

  ),
};
Set<Polyline> polyline = {
Polyline(
  polylineId: PolylineId('locaotn a '),
width: 5,
color: Colors.red,

points: [
  LatLng(23.8103, 90.4125),
  LatLng(22.3569, 91.7832),
]
),
};

Set<Circle> circle = {
  Circle(
    circleId: CircleId('My Araa'),
    radius: 1000,
    fillColor: Colors.blueAccent.shade100,

   strokeColor: Colors.red,
    strokeWidth: 1,
    center: const LatLng(23.8103, 90.4125),
  ),
};
 Set<Marker> markes  = {

   Marker(
     infoWindow: InfoWindow(title: 'Dhaka',snippet: 'my home is dhaka'),
     markerId: MarkerId('dhaka'),
     position: LatLng(23.8103, 90.4125)

   ),

   Marker(
     markerId: MarkerId('dhaka2'),
     position: LatLng(22.3569, 91.7832)
   )

 };

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  late GoogleMapController mapController ;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: GoogleMap(
  onMapCreated: (controller) {
  mapController = controller;
  controller.animateCamera(
    CameraUpdate.newLatLng(
       LatLng(22.3569, 91.7832),

    ),

  );
},

          initialCameraPosition: CameraPosition(target: LatLng(lat, lon),
            zoom: 12,

          ),

        circles: circle,
        markers: markes,
        zoomControlsEnabled: true,
        polylines:polyline ,
        polygons:polygon ,
      ),
    );
  }
}

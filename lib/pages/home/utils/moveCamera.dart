import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

moveCamera(double latitude, double longitude, Completer<GoogleMapController> controllerCompleter) async {
  CameraPosition cPosition = CameraPosition(
    zoom: 15,
    target: LatLng(latitude, longitude),
  );
  final GoogleMapController controller = await controllerCompleter.future;
  controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
}
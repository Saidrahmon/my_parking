import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkovka/config/Config.dart';
import 'package:parkovka/pages/home/utils/createMarkerHelper.dart';
import 'package:parkovka/pages/home/views/Dialog.dart';
import 'package:parkovka/widgets/CustomMarkerWidget.dart';

int polygonCounterId = 0;
int polylineCounterId = 0;
int markerCounterId = 0;

Polygon createPolygon(String namePark, double cost, List<LatLng> points, Function(Marker) addMarker) {
  MarkerGenerator([
    CustomMarkerWidget(costLabel: cost.toString())
  ], (bitmaps) {
    addMarker(createMarker(namePark, cost, bitmaps[0], points));
  }).generate(Get.context!);

  Polygon polygon = Polygon(
      polygonId: PolygonId(polygonCounterId.toString()),
      points: points,
      consumeTapEvents: true,
      strokeColor: Colors.red,
      strokeWidth: 2,
      fillColor: Colors.red.withOpacity(0.5),
      onTap: () {
        showAsBottomSheet(namePark, cost, Config.numberAuto);
      });
  polygonCounterId++;
  return polygon;
}

Polyline createPolyline(String namePark, double cost, List<LatLng> points, Function(Marker) addMarker) {
  MarkerGenerator([
    CustomMarkerWidget(costLabel: cost.toString())
  ], (bitmaps) {
    addMarker(createMarker(namePark, cost, bitmaps[0], points));
  }).generate(Get.context!);

  Polyline polyline = Polyline(
      jointType: JointType.round,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      width: 2,
      polylineId: PolylineId(polylineCounterId.toString()),
      points: points,
      color: Colors.red.withOpacity(0.5),
      onTap: () {
        showAsBottomSheet(namePark, cost, Config.numberAuto);
      },
      consumeTapEvents: true);
  polylineCounterId++;
  return polyline;
}

Marker createMarker(String namePark, double cost, Uint8List markerUint8List, List<LatLng> points) {
  Marker marker = Marker(
    position: LatLng((points[0].latitude + points[1].latitude) / 2,
        (points[0].longitude + points[1].longitude) / 2),
    icon: BitmapDescriptor.fromBytes(markerUint8List),
    markerId: MarkerId(markerCounterId.toString()),
    onTap: () {
      showAsBottomSheet(namePark, cost, Config.numberAuto);
    },
  );
  markerCounterId++;
  return marker;
}
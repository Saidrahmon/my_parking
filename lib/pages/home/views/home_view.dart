import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkovka/pages/home/controllers/HomeController.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Obx(
          () => GoogleMap(
            initialCameraPosition: controller.initPos,
            polygons: controller.polygonSet,
            polylines: controller.polylineSet,
            zoomControlsEnabled: true,
            markers: controller.markers,
            onMapCreated: (GoogleMapController controllerGoogleMap) {
              controller.controllerCompleter.complete(controllerGoogleMap);
            },
          ),
        ),
      ),
    );
  }
}

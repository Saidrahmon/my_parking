import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:parkovka/config/Config.dart';
import 'package:parkovka/pages/home/controllers/HomeController.dart';

class HomeView extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Obx(
          () => GoogleMap(
            initialCameraPosition: Config.initPos,
            polygons: controller.polygonSet,
            polylines: controller.polylineSet,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            onCameraMove: (event){
              Logger().d(event.zoom);
            },
            markers: controller.markerSet,
            onMapCreated: (GoogleMapController controllerGoogleMap) {
              controller.controllerCompleter.complete(controllerGoogleMap);
            },
          ),
        ),
      ),
    );
  }
}

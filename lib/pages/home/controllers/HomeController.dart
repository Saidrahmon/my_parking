import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkovka/data/repositories/RepositoryHome.dart';
import 'package:parkovka/pages/home/utils/createFigures.dart';
import 'package:parkovka/pages/home/utils/locationPermission.dart';
import 'package:parkovka/pages/home/utils/moveCamera.dart';

class HomeController extends GetxController {
  Completer<GoogleMapController> controllerCompleter = Completer();

  var markerSet = Set<Marker>().obs;
  var polylineSet = new Set<Polyline>().obs;
  var polygonSet = new Set<Polygon>().obs;

  @override
  void onInit() {
    sortFigures();
    requestPermissionLocation().then(
      (value) => {
        getCurrentPos()
            .then((value) => {moveCamera(value.latitude, value.longitude, controllerCompleter)}),
      },
    );
  }

  sortFigures(){
    getFigures().forEach((figure) {
      if (figure.geometry.type == 'LineString') {
        List<LatLng> latlngs = [];
        figure.geometry.coordinates.forEach((coord) {
          latlngs.add(LatLng(coord.lat, coord.long));
        });
        addPolylineToSet(figure.namePark, figure.cost, latlngs);
      } else if (figure.geometry.type == 'Polygon') {
        List<LatLng> latlngs = [];
        figure.geometry.coordinates.forEach((coord) {
          latlngs.add(LatLng(coord.lat, coord.long));
        });
        addPolygonToSet(figure.namePark, figure.cost, latlngs);
      }
    });
  }

  addPolylineToSet(String namePark, double cost, List<LatLng> points) {
    polylineSet.add(createPolyline(namePark, cost, points, (Marker marker) {
      markerSet.add(marker);
    }));
  }

  addPolygonToSet(String namePark, double cost, List<LatLng> points) {
    polygonSet.add(createPolygon(namePark, cost, points, (Marker marker) {
      markerSet.add(marker);
    }));
  }
}

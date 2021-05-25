import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as locationPack;
import 'package:location_permissions/location_permissions.dart';
import 'package:logger/logger.dart';
import 'package:parkovka/data/models/FigureModel.dart';
import 'package:parkovka/data/models/GeometryModel.dart';
import 'package:parkovka/pages/home/views/KeyValueWidget.dart';
import 'package:parkovka/widgets/ButtonWidget.dart';
import 'package:sliding_sheet/sliding_sheet.dart';


class HomeController extends GetxController {

  int polylineCounterId = 0;
  int polygonCounterId = 0;
  String numberAuto = '10 A 266 EA';

  static LatLng latLng = LatLng(41.311081, 69.240562);

  CameraPosition initPos = CameraPosition(target: latLng, zoom: 15);

  Completer<GoogleMapController> controllerCompleter = Completer();
  var markers = Set<Marker>().obs;
  var polylineSet = new Set<Polyline>().obs;
  var polygonSet = new Set<Polygon>().obs;
  var isVisibleMarkers = true.obs;

  locationPack.Location? location;

  void mapBitmapsToMarkers(String namePark, double cost, Uint8List markerUint8List, List<LatLng> points) {
    Logger().d(markerUint8List.length);
    markers.add(Marker(
        position: LatLng((points[0].latitude + points[1].latitude) / 2,
            (points[0].longitude + points[1].longitude) / 2),
        icon: BitmapDescriptor.fromBytes(markerUint8List),
        markerId: MarkerId(markers.length.toString()),
      visible: isVisibleMarkers.value,
      onTap: (){
          showAsBottomSheet(namePark, cost);
      }
      ,),);

    // for (int i = 0; i < markerUint8List.length; i++) {
    //   markers.add(Marker(
    //       position: LatLng((points[0].latitude + points[1].latitude) / 2,
    //           (points[0].longitude + points[1].longitude) / 2),
    //       icon: BitmapDescriptor.fromBytes(markerUint8List[i]),
    //       markerId: MarkerId(polylineCounterId.toString())));
    // }
  }

  @override
  void onInit() {
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

    test().then((value) => {
          getCurrentPos()
              .then((value) => {moveCamera(value.latitude, value.longitude)}),
          location = locationPack.Location(),
          Logger().d('jhskfjsdkfnkls'),
          location!.onLocationChanged.listen((event) {
            print('manananananan');
            //updateCurrentPosition(event.latitude!, event.longitude!);
          }),
        });
  }

  moveCamera(double latitude, double longitude) async {
    CameraPosition cPosition = CameraPosition(
      zoom: 15,
      target: LatLng(latitude, longitude),
    );
    final GoogleMapController controller = await controllerCompleter.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));

  }





  updateCurrentPosition(double latitude, double longitude) {
    markers.add(
      Marker(
          markerId: MarkerId('currentPositionMarker'),
          position: LatLng(latitude, longitude),
          icon: BitmapDescriptor.defaultMarker),
    );
  }

  addPolylineToSet(String namePark, double cost, List<LatLng> points) {
    polylineSet.add(createPolyline(namePark, cost, points));
  }

  addPolygonToSet(String namePark, double cost, List<LatLng> points) {
    polygonSet.add(createPolygon(namePark, cost, points));
  }

  Polyline createPolyline(String namePark, double cost, List<LatLng> points) {
    MarkerGenerator(
      [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.red,
          ),
          padding: EdgeInsets.all(10),
          child: Text('$cost uzs', style: TextStyle(color: Colors.white, fontSize: 16),),

        ),
      ], (bitmaps) {
      mapBitmapsToMarkers(namePark, cost, bitmaps[0], points);
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
          Logger().d(namePark);
          showAsBottomSheet(namePark, cost);
        },
        consumeTapEvents: true);
    polylineCounterId++;
    return polyline;
  }

  Polygon createPolygon(String namePark, double cost, List<LatLng> points) {
    MarkerGenerator(
        [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.red,
            ),
            padding: EdgeInsets.all(10),
            child: Text('$cost uzs', style: TextStyle(color: Colors.white, fontSize: 16),),

          ),
        ], (bitmaps) {
      mapBitmapsToMarkers(namePark, cost, bitmaps[0], points);
    }).generate(Get.context!);

    Polygon polygon = Polygon(
        polygonId: PolygonId(polygonCounterId.toString()),
        points: points,
        consumeTapEvents: true,
        strokeColor: Colors.red,
        strokeWidth: 2,
        fillColor: Colors.red.withOpacity(0.5),
        onTap: () {
          Logger().d(namePark);
          showAsBottomSheet(namePark, cost);
        });
    polygonCounterId++;
    return polygon;
  }

  Future<Position> getCurrentPos() async {
    Position pos = await Geolocator.getCurrentPosition();
    return pos;
  }

  Future test() async {
    PermissionStatus permission =
        await LocationPermissions().requestPermissions();
  }

  List<FigureModel> getFigures() {
    List<FigureModel> figures = [
      FigureModel(
        namePark: 'Novoiy ko\'cha 1',
        cost: 4000,
        geometry: GeometryModel(type: 'LineString', coordinates: [
          Coordinate(lat: 41.3219119180153, long: 69.24356460571289),
          Coordinate(lat: 41.32107393459383, long: 69.25437927246094)
        ]),
      ),
      FigureModel(
        namePark: 'Novoiy ko\'cha 2',
        cost: 3000,
        geometry: GeometryModel(type: 'LineString', coordinates: [
          Coordinate(lat: 41.311597526108635, long: 69.24433708190918),
          Coordinate(lat: 41.311404115671714, long: 69.25274848937988)
        ]),
      ),
      FigureModel(
        namePark: 'Novoiy ko\'cha 3',
        cost: 2000,
        geometry: GeometryModel(type: 'LineString', coordinates: [
          Coordinate(lat: 41.31121070466102, long: 69.25386428833008),
          Coordinate(lat: 41.31069493916052, long: 69.26390647888184),
          Coordinate(lat: 41.309405507557635, long: 69.26716804504395),
          Coordinate(lat: 41.30566601169448, long: 69.26545143127441)
        ]),
      ),
      FigureModel(
        namePark: 'Novoiy ko\'cha 4',
        cost: 5000,
        geometry: GeometryModel(type: 'Polygon', coordinates: [
          Coordinate(lat: 41.32075163040873, long: 69.26485061645508),
          Coordinate(lat: 41.31965578425645, long: 69.27154541015625),
          Coordinate(lat: 41.322620972494164, long: 69.27248954772949),
          Coordinate(lat: 41.323458936022696, long: 69.26527976989746),
          Coordinate(lat: 41.32075163040873, long: 69.26485061645508)
        ]),
      ),
    ];
    return figures;
  }

  void showAsBottomSheet(String namePark, double cost) async {
    final result =
        await showSlidingBottomSheet(Get.context!, builder: (context) {
      return SlidingSheetDialog(
        backdropColor: Colors.transparent,
        cornerRadius: 8,
        duration: Duration(milliseconds: 500),
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.5],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        builder: (context, state) {
          return Container(
            height: 300,
            child: Center(
              child: Material(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 4,
                        width: 24,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      KeyValueWidget(label: 'Avtomobil', value: numberAuto),
                      KeyValueWidget(label: 'Parkovka', value: namePark),
                      KeyValueWidget(label: 'Narxi', value: '${cost} so\'m'),
                      ButtonWidget(
                        label: 'Band qilish',
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
    print(result); // This is the result.
  }
}

class MarkerGenerator {
  final Function(List<Uint8List>) callback;
  final List<Widget> markerWidgets;

  MarkerGenerator(this.markerWidgets, this.callback);

  void generate(BuildContext context) {
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context) {
    addOverlay(Get.overlayContext!);
  }

  void addOverlay(BuildContext context) {
    OverlayState? overlayState = Overlay.of(context);

    OverlayEntry entry = OverlayEntry(
        builder: (context) {
          return _MarkerHelper(
            markerWidgets: markerWidgets,
            callback: callback,
          );
        },
        maintainState: true);

    overlayState!.insert(entry);
  }
}

/// Maps are embeding GoogleMap library for Andorid/iOS  into flutter.
///
/// These native libraries accept BitmapDescriptor for marker, which means that for custom markers
/// you need to draw view to bitmap and then send that to BitmapDescriptor.
///
/// Because of that Flutter also cannot accept Widget for marker, but you need draw it to bitmap and
/// that's what this widget does:
///
/// 1) It draws marker widget to tree
/// 2) After painted access the repaint boundary with global key and converts it to uInt8List
/// 3) Returns set of Uint8List (bitmaps) through callback
class _MarkerHelper extends StatefulWidget {
  final List<Widget> markerWidgets;
  final Function(List<Uint8List>) callback;

  const _MarkerHelper({required this.markerWidgets, required this.callback});

  @override
  _MarkerHelperState createState() => _MarkerHelperState();
}

class _MarkerHelperState extends State<_MarkerHelper> with AfterLayoutMixin {
  List<GlobalKey> globalKeys = [];

  @override
  void afterFirstLayout(BuildContext context) {
    _getBitmaps(context).then((list) {
      widget.callback(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(MediaQuery.of(context).size.width, 0),
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          children: widget.markerWidgets.map((i) {
            final markerKey = GlobalKey();
            globalKeys.add(markerKey);
            return RepaintBoundary(
              key: markerKey,
              child: i,
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<List<Uint8List>> _getBitmaps(BuildContext context) async {
    var futures = globalKeys.map((key) => _getUint8List(key));
    return Future.wait(futures);
  }

  Future<Uint8List> _getUint8List(GlobalKey markerKey) async {
    RenderRepaintBoundary boundary =
        markerKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: 2.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }
}

/// AfterLayoutMixin
mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context);
}

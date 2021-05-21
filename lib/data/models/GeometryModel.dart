import 'package:flutter/cupertino.dart';

class GeometryModel{

  String type;
  List<Coordinate> coordinates;

  GeometryModel({required this.type, required this.coordinates});
}

class Coordinate{
  double lat;
  double long;
  Coordinate({required this.lat, required this.long});
}
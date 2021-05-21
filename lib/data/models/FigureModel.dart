import 'package:parkovka/data/models/FigureModel.dart';
import 'package:parkovka/data/models/GeometryModel.dart';

class FigureModel{
  String namePark;
  double cost;
  String type = 'Feature';
  //List properties = null;
  GeometryModel geometry;

  FigureModel({required this.namePark, required this.cost, required this.geometry});

}
import 'package:parkovka/data/models/FigureModel.dart';
import 'package:parkovka/data/models/GeometryModel.dart';

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
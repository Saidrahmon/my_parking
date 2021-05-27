import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';

Future<Position> getCurrentPos() async {
  Position pos = await Geolocator.getCurrentPosition();
  return pos;
}

Future requestPermissionLocation() async {
  PermissionStatus permission =
  await LocationPermissions().requestPermissions();
}
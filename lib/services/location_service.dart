import 'package:location/location.dart';

class LocationServices {
  static final _location = Location();

  static bool isServiceEnable = false;
  static PermissionStatus permissionStatus = PermissionStatus.denied;
  static LocationData? currentLocation;

  static Future<void> init() async {
    await checkService();
    await checkPermission();
  }

  static Future<void> checkService() async {
    isServiceEnable = await _location.serviceEnabled();

    if (!isServiceEnable) {
      isServiceEnable = await _location.requestService();
      if (!isServiceEnable) {
        return; 
      }
    }
  }

  static Future<void> checkPermission() async {
    permissionStatus = await _location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return; 
      }
    }
  }

  static Future<void> getCurrentLocation() async {
    if (isServiceEnable && permissionStatus == PermissionStatus.granted) {
      currentLocation = await _location.getLocation();
    }
  }
}
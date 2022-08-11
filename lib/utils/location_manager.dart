import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationManager {

  static late LocationManager _instance;
  LocationData? locationData;
  final Location? location;

  LocationManager._() : location = Location();
  static Future initialize() async {
    _instance = LocationManager._();
    _performPermissions();
  }

  factory LocationManager.getInstance() {
    return _instance;
  }

  static void _performPermissions() async {
    try {
      var serviceEnabled = await _instance.location?.serviceEnabled();
      if (!serviceEnabled!) {
        serviceEnabled = await _instance.location?.requestService();
        if (!serviceEnabled!) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var permissionGranted = await _instance.location?.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _instance.location?.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      _instance.locationData = await _instance.location?.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      _instance.locationData = null;
    }
  }

  Future<LocationData?> getCurrentLocation() async {
   return await _instance.location?.getLocation();
  }
}


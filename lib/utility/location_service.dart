import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc_pkg;
import 'package:geocoding/geocoding.dart';
class LocationService {
  late loc_pkg.Location _location;

  LocationService() {
    _location = loc_pkg.Location();
  }

  /// Check if permission is denied.
  Future<bool> hasNotAllowed() async {
    return (await _location.hasPermission()) == loc_pkg.PermissionStatus.denied;
  }

  /// Check and request location permissions.
  Future<bool> checkPermission() async {
    loc_pkg.PermissionStatus? grantedPermission;
    if (await checkService()) {
      try {
        grantedPermission = await _location.hasPermission();
        if (grantedPermission == loc_pkg.PermissionStatus.denied) {
          grantedPermission = await _location.requestPermission();
          return grantedPermission == loc_pkg.PermissionStatus.granted ||
              grantedPermission == loc_pkg.PermissionStatus.grantedLimited;
        } else if (grantedPermission == loc_pkg.PermissionStatus.deniedForever) {
          return false;
        } else {
          return grantedPermission == loc_pkg.PermissionStatus.granted ||
              grantedPermission == loc_pkg.PermissionStatus.grantedLimited;
        }
      } catch (e, st) {
        debugPrint(e.toString());
        debugPrintStack(stackTrace: st);
        return false;
      }
    }
    return false;
  }

  /// Check if location service is enabled.
  Future<bool> checkService() async {
    bool serviceEnabled = false;
    try {
      serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
      }
    } on PlatformException catch (error) {
      debugPrint('Error code: ${error.code}, message: ${error.message}');
      serviceEnabled = false;
    }
    return serviceEnabled;
  }



  /// Convert latitude and longitude to a human-readable address.
  Future<String?> getAddressFromLatLong(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return '${place.locality}, ${place.administrativeArea}, ${place.country}';
      } else {
        throw Exception('No placemarks found for the given coordinates.');
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: st);
      return null;
    }
  }

  /// Check if location services and permissions are ready.
  Future<bool> isLocationReady() async {
    bool serviceEnabled = await checkService();
    bool permissionGranted = await checkPermission();
    return serviceEnabled && permissionGranted;
  }


}

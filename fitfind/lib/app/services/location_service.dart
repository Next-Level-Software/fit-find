import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';
import 'package:logger/logger.dart';

class LocationService {
  LocationService._();

  static bool isInUS(double latitude, double longitude) {
    double minLat = 24.396308;
    double maxLat = 49.384358;
    double minLng = -125.000000;
    double maxLng = -66.934570;

    return (latitude >= minLat && latitude <= maxLat) &&
        (longitude >= minLng && longitude <= maxLng);
  }

  static Future<LocationData?> getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check if location services are enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    // Check if the app has permission to access location
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    var locationData = await location.getLocation();

    return locationData;
  }

  static Future<String?> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<geocoding.Placemark> placeMarks =
          await geocoding.placemarkFromCoordinates(lat, lng);

      if (placeMarks.isNotEmpty) {
        geocoding.Placemark place = placeMarks.first;
        String street =
            place.street?.isEmpty ?? true ? "" : "${place.street}, ";
        String subLocality =
            place.subLocality?.isEmpty ?? true ? "" : "${place.subLocality}, ";
        String locality =
            place.locality?.isEmpty ?? true ? "" : "${place.locality}, ";
        String administrativeArea = place.administrativeArea?.isEmpty ?? true
            ? ""
            : "${place.administrativeArea}, ";
        String country =
            place.country?.isEmpty ?? true ? "" : "${place.country}";

        String currentAddress =
            "$street$subLocality$locality$administrativeArea$country";
        return currentAddress;
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}

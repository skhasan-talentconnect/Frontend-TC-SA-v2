import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationUtils {
  static Future<Map<String, String>?> getCurrentPlace() async {
    try {
      // 1. Get current position
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // 2. Reverse geocode to get address details
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isEmpty) return null;

      final placemark = placemarks.first;

      return {
        'state': placemark.administrativeArea ?? '',
        'city': placemark.locality ?? '',
        'area': placemark.subLocality ?? '',
      };
    } catch (e) {
      print("Error in getCurrentPlace: $e");
      return null;
    }
  }
}

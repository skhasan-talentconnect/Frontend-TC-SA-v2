import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tc_sa/core/index.dart';

class LocationUtils {
  // Update the return type to handle double values for coordinates
  static Future<Map<String, dynamic>?> getCurrentPlace() async {
    try {
      // 1. Get current position (which contains lat/lon)
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // 2. Reverse geocode to get address details
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isEmpty) return null;

      final placemark = placemarks.first;

      // 3. Return a map including the coordinates
      return {
        'latitude': position.latitude,
        'longitude': position.longitude,
        'state': placemark.administrativeArea ?? '',
        'city': placemark.locality ?? '',
        'area': placemark.subLocality ?? '',
      };
    } catch (e) {
      print("Error in getCurrentPlace: $e");
      return null;
    }
  }

  static String getDistanceFromUser(double? lat, double? long) {
    final userLat = getIt<AppStateProvider>().user?.latitude;
    final userLong = getIt<AppStateProvider>().user?.longitude;

    log('$userLat, $userLong, $lat, $long');

    if (userLat == null || userLong == null || lat == null || long == null) {
      return '';
    }

    double distanceInMeters = Geolocator.distanceBetween(
      userLat,
      userLong,
      lat,
      long,
    );

    double distanceInKiloMeters = distanceInMeters / 1000;

    return '● ${distanceInKiloMeters.toStringAsFixed(1)} Km';
  }
}

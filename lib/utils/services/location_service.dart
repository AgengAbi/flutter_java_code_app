import 'package:flutter_java_code_app/constants/app_constant.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationServices {
  /// Ensure this class cannot be instantiated
  LocationServices._();

  static Stream<ServiceStatus> streamService =
      Geolocator.getServiceStatusStream();

  /// Get location information
  static Future<LocationResult> getCurrentPosition() async {
    /// Is location service enabled?
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      /// If not, return an error message
      return LocationResult.error(message: 'Location service not enabled'.tr);
    }

    /// Check location permission
    LocationPermission permission = await Geolocator.checkPermission();

    /// Is location permission denied?
    if (permission == LocationPermission.denied) {
      /// If denied, request permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        /// If permission is denied, return an error message
        return LocationResult.error(
          message: 'Location permission not granted'.tr,
        );
      }
    }

    /// Is location permission permanently denied?
    if (permission == LocationPermission.deniedForever) {
      /// If permanently denied, return an error message
      return LocationResult.error(
        message: 'Location permission not granted forever'.tr,
      );
    }

    /// If location permission is granted, get the location
    late Position position;
    try {
      position = await Geolocator.getCurrentPosition();
    } catch (e) {
      return LocationResult.error(message: 'Location service not enabled'.tr);
    }

    /// Calculate the distance to the target location in meters
    double distanceInMeters = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      AppConstants.locationLatitude,
      AppConstants.locationLongitude,
    );

    /// Is the location within the specified radius of the target location?
    if (distanceInMeters > AppConstants.maximumDistance) {
      /// If not, return an error message
      return LocationResult.error(message: 'Distance not close'.tr);
    }

    /// Get location details
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isEmpty) {
      /// If no location details are available, return an error message
      return LocationResult.error(message: 'Unknown location'.tr);
    }

    /// If location details are available, return the location information
    return LocationResult.success(
      position: position,
      address: [
        placemarks.first.name,
        placemarks.first.subLocality,
        placemarks.first.locality,
        placemarks.first.administrativeArea,
        placemarks.first.postalCode,
        placemarks.first.country,
      ].where((e) => e != null).join(', '),
    );
  }
}

class LocationResult {
  final bool success;
  final Position? position;
  final String? address;
  final String? message;

  LocationResult({
    required this.success,
    this.position,
    this.address,
    this.message,
  });

  factory LocationResult.success(
      {required Position position, required String address}) {
    return LocationResult(
      success: true,
      position: position,
      address: address,
    );
  }

  factory LocationResult.error({required String message}) {
    return LocationResult(
      success: false,
      message: message,
    );
  }
}

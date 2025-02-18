class AppConstants {
  /// Latitude of the target location
  // static const double locationLatitude = -7.9422705302492105;
  static const double locationLatitude = -7.924998084201822;

  /// Longitude of the target location
  // static const double locationLongitude = 112.62298304965235;
  static const double locationLongitude = 112.65309406565733;

  /// Maximum allowed distance from the target location in meters
  static const double maximumDistance = 100.0;

  /// Default location name
  // static const String defaultLocationName = "Kantor Venturo Pro Indonesia";
  static const String defaultLocationName = "Near Home";

  /// Timeout duration for location fetching in milliseconds
  static const int locationFetchTimeout = 10000;

  /// Minimum distance to trigger location update in meters
  static const double locationUpdateMinDistance = 10.0;

  /// Minimum time interval between location updates in milliseconds
  static const int locationUpdateMinTime = 5000;
}

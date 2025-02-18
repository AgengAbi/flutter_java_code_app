import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// Function to log screen view based on platform
  static void logScreen(String screenName) {
    if (kIsWeb) {
      _analytics.logScreenView(
        screenName: screenName,
        screenClass: 'Web',
      );
    } else if (Platform.isAndroid) {
      _analytics.logScreenView(
        screenName: screenName,
        screenClass: 'Android',
      );
    } else if (Platform.isIOS) {
      _analytics.logScreenView(
        screenName: screenName,
        screenClass: 'iOS',
      );
    } else if (Platform.isMacOS) {
      _analytics.logScreenView(
        screenName: screenName,
        screenClass: 'MacOS',
      );
    }
    // if (Platform.isAndroid) {
    //   _analytics.logScreenView(
    //     screenName: screenName,
    //     screenClass: 'Android',
    //   );
    // } else if (Platform.isIOS) {
    //   _analytics.logScreenView(
    //     screenName: screenName,
    //     screenClass: 'iOS',
    //   );
    // } else if (Platform.isMacOS) {
    //   _analytics.logScreenView(
    //     screenName: screenName,
    //     screenClass: 'MacOS',
    //   );
    // } else if (kIsWeb) {
    //   _analytics.logScreenView(
    //     screenName: screenName,
    //     screenClass: 'Web',
    //   );
    // }
  }
}

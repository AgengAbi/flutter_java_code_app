import 'package:flutter/material.dart';

class ModalRoute {
  // Membuat modal route dengan nama tertentu yang dapat digunakan di GetX
  static RoutePredicate withName(String routeName) {
    return (Route route) {
      return route.settings.name == routeName;
    };
  }
}

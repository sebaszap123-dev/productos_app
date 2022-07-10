import 'package:flutter/material.dart';

class BoxShadowApp {
  static List<BoxShadow> get boxShadowProduct {
    return [
      BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: Offset(0, 5))
    ];
  }
}

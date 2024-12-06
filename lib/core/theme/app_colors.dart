import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryText = Color(0xFF000000);
  static const Color buttonBorder = Color(0xFF000000);
  static const Color buttonText = Color(0xFF000000);

  // Serene Blues Palette
  static const Color lightestBlue = Color(0xFFB3E5FC);  // #B3E5FC
  static const Color lighterBlue = Color(0xFF81D4FA);   // #81D4FA
  static const Color mediumBlue = Color(0xFF4FC3F7);    // #4FC3F7
  static const Color darkerBlue = Color(0xFF29B6F6);    // #29B6F6
  static const Color darkestBlue = Color(0xFF0288D1);   // #0288D1

  // Main Background Color
  static const Color background = lightestBlue;

  // Gradient Colors for potential use
  static final List<Color> blueGradient = [
    lightestBlue,
    lighterBlue,
    mediumBlue,
    darkerBlue,
    darkestBlue,
  ];
}

import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF2196F3);    // Blue
  static const Color background = Color(0xFF121212); // Material Dark Background
  static const Color surface = Color(0xFF1E1E1E);    // Slightly lighter black
  static const Color cardColor = Color(0xFF2C2C2C);  // Even lighter for cards
  
  // Text Colors
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xB3FFFFFF);  // 70% white
  static const Color tertiaryText = Color(0x80FFFFFF);   // 50% white

  // Border Colors
  static const Color borderColor = Colors.grey;

  // Accent Colors for highlights
  static const Color accentBlue = Color(0xFF2196F3);
  static const Color accentBlueLight = Color(0xFF64B5F6);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA726);

  // Gradients
  static const List<Color> backgroundGradient = [
    Color(0xFF1A1A1A),
    Color(0xFF121212),
  ];
}

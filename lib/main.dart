import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/screens/role_selection/role_selection_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctor Buddy',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const RoleSelectionScreen(),
    );
  }
}

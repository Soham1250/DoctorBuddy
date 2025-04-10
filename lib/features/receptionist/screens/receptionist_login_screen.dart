import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets/custom_text_field.dart';
import 'receptionist_main_screen.dart';

class ReceptionistLoginScreen extends StatefulWidget {
  const ReceptionistLoginScreen({super.key});

  @override
  State<ReceptionistLoginScreen> createState() =>
      _ReceptionistLoginScreenState();
}

class _ReceptionistLoginScreenState extends State<ReceptionistLoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _handleLogin() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username == 'Recept123' && password == 'Recept123') {
      setState(() {
        _errorMessage = null;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ReceptionistMainScreen(),
        ),
      );
    } else {
      setState(() {
        _errorMessage = 'Invalid username or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo or Avatar Circle
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.surface,
                      border: Border.all(
                        color: AppColors.borderColor,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      size: 70,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Title
                  const Text(
                    'Receptionist Login',
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  const Text(
                    'Sign in to manage appointments',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Username Field
                  CustomTextField(
                    hint: 'Username',
                    controller: _usernameController,
                    prefixIcon: Icons.person,
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  CustomTextField(
                    hint: 'Password',
                    controller: _passwordController,
                    isPassword: true,
                    obscureText: _obscurePassword,
                    onToggleVisibility: _togglePasswordVisibility,
                    prefixIcon: Icons.lock,
                  ),

                  // Error Message
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: AppColors.error,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  const SizedBox(height: 32),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.primaryText,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Bottom Links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.accentBlue,
                        ),
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

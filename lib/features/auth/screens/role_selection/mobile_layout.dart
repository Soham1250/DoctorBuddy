import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/role_button.dart';

class MobileLayout extends StatelessWidget {
  final VoidCallback onDoctorPressed;
  final VoidCallback onReceptionistPressed;

  const MobileLayout({
    super.key,
    required this.onDoctorPressed,
    required this.onReceptionistPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomText(
              text: 'Hello there,\nYou must be',
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 40),
            RoleButton(
              text: 'Doctor',
              onPressed: onDoctorPressed,
            ),
            const SizedBox(height: 20),
            RoleButton(
              text: 'Receptionist',
              onPressed: onReceptionistPressed,
            ),
          ],
        ),
      ),
    );
  }
}

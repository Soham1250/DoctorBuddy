import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/role_button.dart';

class TabletLayout extends StatelessWidget {
  final VoidCallback onDoctorPressed;
  final VoidCallback onReceptionistPressed;

  const TabletLayout({
    super.key,
    required this.onDoctorPressed,
    required this.onReceptionistPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomText(
            text: 'Hello there,\nYou must be',
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoleButton(
                text: 'Doctor',
                onPressed: onDoctorPressed,
                width: 250,
                height: 60,
              ),
              const SizedBox(width: 40),
              RoleButton(
                text: 'Receptionist',
                onPressed: onReceptionistPressed,
                width: 250,
                height: 60,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

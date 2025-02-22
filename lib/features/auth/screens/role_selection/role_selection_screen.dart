import 'package:flutter/material.dart';
// import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../receptionist/screens/receptionist_login_screen.dart';
import 'mobile_layout.dart';
import 'tablet_layout.dart';
import '../../../doctor/screens/login/doctor_login_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  void _navigateToDoctor(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const DoctorLoginScreen(),
      ),
    );
  }

  void _navigateToReceptionist(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const ReceptionistLoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 600) {
              return TabletLayout(
                onDoctorPressed: () => _navigateToDoctor(context),
                onReceptionistPressed: () => _navigateToReceptionist(context),
              );
            }
            return MobileLayout(
              onDoctorPressed: () => _navigateToDoctor(context),
              onReceptionistPressed: () => _navigateToReceptionist(context),
            );
          },
        ),
      ),
    );
  }
}

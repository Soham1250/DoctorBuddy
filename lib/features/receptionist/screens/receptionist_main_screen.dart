import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../models/appointment.dart';
import '../widgets/appointment_list.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/header_section.dart';

class ReceptionistMainScreen extends StatefulWidget {
  const ReceptionistMainScreen({super.key});

  @override
  State<ReceptionistMainScreen> createState() => _ReceptionistMainScreenState();
}

class _ReceptionistMainScreenState extends State<ReceptionistMainScreen> {
  int _currentIndex = 0;
  final List<Appointment> _appointments = [
    Appointment(
      patientName: 'John Doe',
      patientId: 'PT001',
      appointmentTime: '9:00 AM',
      reason: 'Regular Checkup',
    ),
    Appointment(
      patientName: 'Jane Smith',
      patientId: 'PT002',
      appointmentTime: '10:30 AM',
      reason: 'Dental Cleaning',
    ),
    Appointment(
      patientName: 'Robert Johnson',
      patientId: 'PT003',
      appointmentTime: '11:45 AM',
      reason: 'Follow-up Visit',
    ),
    Appointment(
      patientName: 'Emily Brown',
      patientId: 'PT004',
      appointmentTime: '2:15 PM',
      reason: 'Consultation',
    ),
    Appointment(
      patientName: 'Michael Wilson',
      patientId: 'PT005',
      appointmentTime: '3:30 PM',
      reason: 'Blood Test Results',
    ),
  ];

  void _handleBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    // TODO: Implement navigation actions
  }

  void _handleDoneForDay() {
    // TODO: Implement done for day action
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const HeaderSection(username: 'Doctor123'),
            Expanded(
              child: AppointmentList(
                appointments: _appointments,
                onDoneForDay: _handleDoneForDay,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _handleBottomNavTap,
      ),
    );
  }
}

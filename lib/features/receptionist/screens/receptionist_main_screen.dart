import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../models/appointment.dart';
import '../models/daily_record.dart';
import '../widgets/appointment_list.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/header_section.dart';
import '../services/daily_record_service.dart';
import 'make_appointment_screen.dart';
import 'search_patient_screen.dart';
import 'add_patient_screen.dart';
import 'history.dart';

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
    ),
    Appointment(
      patientName: 'Jane Smith',
      patientId: 'PT002',
      appointmentTime: '10:30 AM',
    ),
    Appointment(
      patientName: 'Robert Johnson',
      patientId: 'PT003',
      appointmentTime: '11:45 AM',
    ),
    Appointment(
      patientName: 'Emily Brown',
      patientId: 'PT004',
      appointmentTime: '2:15 PM',
    ),
    Appointment(
      patientName: 'Michael Wilson',
      patientId: 'PT005',
      appointmentTime: '3:30 PM',
    ),
  ];

  final List<DailyRecord> _dailyRecords = [];

  void _handleDoneForDay() {
    if (_appointments.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No appointments to save!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.lighterBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.black),
          ),
          title: const Text(
            'End Day Confirmation',
            style: TextStyle(color: Colors.black),
          ),
          content: const Text(
            'Are you sure you want to end the day?',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text(
                'No',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final currentDate =
                    DateFormat('dd MMM yyyy').format(DateTime.now());
                final dailyRecord = DailyRecord(
                  date: currentDate,
                  appointments: List<Appointment>.from(_appointments),
                  status: 'Completed',
                  timestamp: DateTime.now(),
                );

                // Save daily record to in-memory list
                _dailyRecords.add(dailyRecord);

                // Clear appointments
                setState(() {
                  _appointments.clear();
                });

                if (mounted) {
                  Navigator.of(context).pop(); // Close dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Appointments for $currentDate saved successfully!'),
                      backgroundColor: AppColors.darkestBlue,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mediumBlue,
                side: const BorderSide(color: Colors.black),
              ),
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleCancelAppointment(Appointment appointment) {
    setState(() {
      appointment.cancelAppointment();
      
      // Update the appointment in daily records if it exists
      for (var record in _dailyRecords) {
        final appointmentIndex = record.appointments
            .indexWhere((a) => a.patientId == appointment.patientId);
        if (appointmentIndex != -1) {
          record.appointments[appointmentIndex].cancelAppointment();
        }
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Appointment for ${appointment.patientName} cancelled'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _handleBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 2) {
      // Make Appointment
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MakeAppointmentScreen(),
        ),
      );
    } else if (index == 0) {
      // Search Patient
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SearchPatientScreen(),
        ),
      );
    } else if (index == 3) {
      // Add Patient
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddPatientScreen(),
        ),
      );
    } else if (index == 1) {
      // history
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HistoryScreen(dailyRecords: _dailyRecords),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightestBlue,
      body: SafeArea(
        child: Column(
          children: [
            const HeaderSection(username: 'Dr. Smith'),
            Expanded(
              child: AppointmentList(
                appointments: _appointments,
                showCompleteButton: false,
                onDoneForDay: _handleDoneForDay,
                onCancelAppointment: _handleCancelAppointment,
              ),
            ),
            BottomNavigation(
              currentIndex: _currentIndex,
              onTap: _handleBottomNavTap,
            ),
          ],
        ),
      ),
    );
  }
}

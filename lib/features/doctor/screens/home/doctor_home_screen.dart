import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../search/search_patient_screen.dart';
import '../patient/patient_details_screen.dart';
import '../../models/appointment.dart';
import '../../models/patient.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  bool _isExpanded = true;
  List<Appointment> appointments = [
    Appointment(
      id: 'APT001',
      patientId: 'PT001',
      isCompleted: false,
      notesImageUrl: '',
      patient: Patient(
        id: 'PT001',
        name: 'John Doe',
        age: 35,
        gender: 'Male',
        phoneNumber: '123-456-7890',
        lastVisit: DateTime.now().subtract(const Duration(days: 30)),
      ),
    ),
    Appointment(
      id: 'APT002',
      patientId: 'PT002',
      isCompleted: false,
      notesImageUrl: '',
      patient: Patient(
        id: 'PT002',
        name: 'Jane Smith',
        age: 28,
        gender: 'Female',
        phoneNumber: '234-567-8901',
        lastVisit: DateTime.now().subtract(const Duration(days: 60)),
      ),
    ),
    Appointment(
      id: 'APT003',
      patientId: 'PT003',
      isCompleted: false,
      notesImageUrl: '',
      patient: Patient(
        id: 'PT003',
        name: 'Mike Johnson',
        age: 45,
        gender: 'Male',
        phoneNumber: '345-678-9012',
        lastVisit: DateTime.now().subtract(const Duration(days: 15)),
      ),
    ),
    Appointment(
      id: 'APT004',
      patientId: 'PT004',
      isCompleted: false,
      notesImageUrl: '',
      patient: Patient(
        id: 'PT004',
        name: 'Sarah Wilson',
        age: 52,
        gender: 'Female',
        phoneNumber: '456-789-0123',
        lastVisit: DateTime.now().subtract(const Duration(days: 45)),
      ),
    ),
  ];

  void _handleSearchPatient(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DoctorSearchPatientScreen(),
      ),
    );
  }

  void _handleAppointmentComplete(
      String patientId, String appointmentId, String notesImageUrl) {
    // Update appointment status in the database
    // This is a mock implementation - replace with actual database update
    setState(() {
      appointments = appointments.map((appointment) {
        if (appointment.id == appointmentId) {
          return appointment.copyWith(
            isCompleted: true,
            notesImageUrl: notesImageUrl,
          );
        }
        return appointment;
      }).toList();
    });
  }

  void _viewPatientDetails(String patientId, String appointmentId) {
    final appointment = appointments.firstWhere(
      (apt) => apt.id == appointmentId,
      orElse: () => throw Exception('Appointment not found'),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientDetailsScreen(
          patient: appointment.patient,
          appointmentId: appointmentId,
          onAppointmentComplete: (notesImageUrl) => _handleAppointmentComplete(
              patientId, appointmentId, notesImageUrl),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final today = DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome Back,',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Dr. Smith',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        today,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => _handleSearchPatient(context),
                    icon: const Icon(
                      Icons.search,
                      color: AppColors.primaryText,
                      size: 28,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Today's Schedule Section
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Column(
                    children: [
                      // Schedule Header
                      ListTile(
                        title: const Text(
                          'Today\'s Schedule',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            _isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: AppColors.primaryText,
                          ),
                          onPressed: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                        ),
                      ),

                      // Appointment List
                      if (_isExpanded)
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  // Appointment Stats
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      _buildStatCard(
                                        'Total',
                                        appointments.length.toString(),
                                        Icons.calendar_today,
                                      ),
                                      _buildStatCard(
                                        'Completed',
                                        appointments
                                            .where((apt) => apt.isCompleted)
                                            .length
                                            .toString(),
                                        Icons.check_circle,
                                      ),
                                      _buildStatCard(
                                        'Pending',
                                        appointments
                                            .where((apt) => !apt.isCompleted)
                                            .length
                                            .toString(),
                                        Icons.pending,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),

                                  // Appointment List
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: appointments.length,
                                    itemBuilder: (context, index) {
                                      final appointment = appointments[index];
                                      return Card(
                                        margin: const EdgeInsets.only(bottom: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          side: const BorderSide(
                                            color: AppColors.borderColor,
                                          ),
                                        ),
                                        color: AppColors.surface,
                                        child: ListTile(
                                          contentPadding: const EdgeInsets.all(16),
                                          title: Text(
                                            appointment.patient.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: AppColors.primaryText,
                                            ),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 4),
                                              Text(
                                                'Age: ${appointment.patient.age} | Gender: ${appointment.patient.gender}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: AppColors.secondaryText,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                appointment.isCompleted
                                                    ? 'Status: Completed'
                                                    : 'Status: Pending',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: appointment.isCompleted
                                                      ? AppColors.success
                                                      : AppColors.warning,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          onTap: () => _viewPatientDetails(
                                            appointment.patientId,
                                            appointment.id,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryText),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}

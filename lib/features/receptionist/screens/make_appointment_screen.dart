import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../models/appointment.dart';

class MakeAppointmentScreen extends StatefulWidget {
  final Function(Appointment) onAppointmentCreated;

  const MakeAppointmentScreen({
    super.key,
    required this.onAppointmentCreated,
  });

  @override
  State<MakeAppointmentScreen> createState() => _MakeAppointmentScreenState();
}

class _MakeAppointmentScreenState extends State<MakeAppointmentScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  bool _patientFound = false;
  Map<String, String>? _patientDetails;
  String? _selectedTime;

  void _searchPatient() {
    if (_searchController.text.toLowerCase() == 'john doe') {
      setState(() {
        _patientFound = true;
        _patientDetails = {
          'Gender': 'Male',
          'Age': '45',
          'Last visited': '15 Jan 2024',
          'Brief history': 'Regular checkups, No major conditions',
        };
      });
    } else {
      setState(() {
        _patientFound = false;
        _patientDetails = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Patient not found'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: AppColors.lighterBlue,
              hourMinuteShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Colors.black),
              ),
              dayPeriodBorderSide: const BorderSide(color: Colors.black),
              dayPeriodShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Colors.black),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Colors.black),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked.format(context);
        _timeController.text = _selectedTime!;
      });
    }
  }

  void _createAppointment() {
    if (!_patientFound) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please search for a patient first'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select appointment time'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final newAppointment = Appointment(
      patientName: _searchController.text,
      patientId: 'PT001', // In real app, this would be generated
      appointmentTime: _selectedTime!,
    );

    widget.onAppointmentCreated(newAppointment);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Appointment created successfully'),
        duration: Duration(milliseconds: 700),
        backgroundColor: Colors.green,
      ),
    );
    
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightestBlue,
      appBar: AppBar(
        backgroundColor: AppColors.darkestBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Make Appointment',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.lighterBlue,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Enter Patient Name',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _searchPatient,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mediumBlue,
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Search',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (_patientFound) ...[
              // Patient Details
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.lighterBlue,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Patient Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ..._patientDetails!.entries.map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Text(
                              '${e.key}: ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              e.value,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Time Selection
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.lighterBlue,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _timeController,
                        readOnly: true,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Select Time',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () => _selectTime(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mediumBlue,
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Pick Time',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Create Appointment Button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _createAppointment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mediumBlue,
                    side: const BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Create Appointment',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

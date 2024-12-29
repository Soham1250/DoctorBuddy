import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../models/patient.dart';

class DoctorHistoryScreen extends StatefulWidget {
  const DoctorHistoryScreen({super.key});

  @override
  State<DoctorHistoryScreen> createState() => _DoctorHistoryScreenState();
}

class _DoctorHistoryScreenState extends State<DoctorHistoryScreen> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Mock data for demonstration
  final List<Map<String, dynamic>> _mockAppointments = [
    {
      'date': '29 Dec 2024',
      'patients': [
        {
          'name': 'John Doe',
          'time': '09:00 AM',
          'status': 'Completed',
          'notes': 'Regular checkup, prescribed medications for hypertension',
        },
        {
          'name': 'Jane Smith',
          'time': '10:30 AM',
          'status': 'Completed',
          'notes': 'Follow-up visit, recovery progressing well',
        },
      ],
    },
    {
      'date': '28 Dec 2024',
      'patients': [
        {
          'name': 'Robert Johnson',
          'time': '02:00 PM',
          'status': 'Completed',
          'notes': 'Initial consultation, ordered blood tests',
        },
      ],
    },
  ];

  List<Map<String, dynamic>> _getAppointmentsForDay(DateTime day) {
    final formattedDate = DateFormat('dd MMM yyyy').format(day);
    return _mockAppointments
        .where((record) => record['date'] == formattedDate)
        .toList();
  }

  void _showAppointmentDetails(BuildContext context, Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(appointment['name']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Time:', appointment['time']),
              _buildDetailRow('Status:', appointment['status']),
              const SizedBox(height: 8),
              const Text(
                'Notes:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(appointment['notes']),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient History'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.blueGrey,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: _buildAppointmentsList(
              _getAppointmentsForDay(_selectedDay ?? _focusedDay),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentsList(List<Map<String, dynamic>> records) {
    if (records.isEmpty) {
      return const Center(
        child: Text('No appointments for this day'),
      );
    }

    return ListView.builder(
      itemCount: records.length,
      itemBuilder: (context, recordIndex) {
        final record = records[recordIndex];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                record['date'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: record['patients'].length,
              itemBuilder: (context, patientIndex) {
                final appointment = record['patients'][patientIndex];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(appointment['name']),
                    subtitle: Text('${appointment['time']} - ${appointment['status']}'),
                    onTap: () => _showAppointmentDetails(context, appointment),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

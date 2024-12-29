import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../models/appointment.dart';

class AppointmentList extends StatelessWidget {
  final List<Appointment> appointments;
  final VoidCallback onDoneForDay;
  final Function(Appointment) onCancelAppointment;
  final bool showCompleteButton;

  const AppointmentList({
    super.key,
    required this.appointments,
    required this.onDoneForDay,
    required this.showCompleteButton,
    required this.onCancelAppointment,
  });

  void _showCancelConfirmation(BuildContext context, Appointment appointment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.borderColor),
          ),
          title: const Text(
            'Cancel Appointment',
            style: TextStyle(color: AppColors.primaryText),
          ),
          content: const Text(
            'Are you sure you want to cancel this appointment?',
            style: TextStyle(color: AppColors.primaryText),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(color: AppColors.primaryText),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                onCancelAppointment(appointment);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.background,
                side: const BorderSide(color: AppColors.borderColor),
              ),
              child: const Text(
                'Yes',
                style: TextStyle(color: AppColors.primaryText),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: appointments.isEmpty
              ? const Center(
                  child: Text(
                    'No appointments for today',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.primaryText,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    final appointment = appointments[index];
                    return Card(
                      color: AppColors.background,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: AppColors.borderColor),
                      ),
                      child: ListTile(
                        title: Text(
                          appointment.details,
                          style: const TextStyle(color: AppColors.primaryText),
                        ),
                        trailing: appointment.isDeclined
                            ? const Text(
                                'Cancelled',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : IconButton(
                                icon: const Icon(Icons.cancel_outlined),
                                color: Colors.red,
                                onPressed: () => _showCancelConfirmation(
                                    context, appointment),
                              ),
                      ),
                    );
                  },
                ),
        ),
        if (appointments.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: onDoneForDay,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.background,
                  side: const BorderSide(color: AppColors.borderColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Done for Day',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

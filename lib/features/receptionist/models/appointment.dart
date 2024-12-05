class Appointment {
  final String patientName;
  final String patientId;
  final String appointmentTime;
  final String reason;
  final bool isCompleted;
  final bool isDeclined;

  Appointment({
    required this.patientName,
    required this.patientId,
    required this.appointmentTime,
    required this.reason,
    this.isCompleted = false,
    this.isDeclined = false,
  });

  String get details => 
    '$patientName (ID: $patientId)\n'
    'Time: $appointmentTime\n'
    'Reason: $reason';
}

class Appointment {
  final String patientName;
  final String patientId;
  final String appointmentTime;
  bool isCompleted;
  bool isDeclined;

  Appointment({
    required this.patientName,
    required this.patientId,
    required this.appointmentTime,
    this.isCompleted = false,
    this.isDeclined = false,
  });

  void cancelAppointment() {
    isDeclined = true;
  }

  Map<String, dynamic> toJson() {
    return {
      'patientName': patientName,
      'patientId': patientId,
      'appointmentTime': appointmentTime,
      'isCompleted': isCompleted,
      'isDeclined': isDeclined,
    };
  }

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      patientName: json['patientName'],
      patientId: json['patientId'],
      appointmentTime: json['appointmentTime'],
      isCompleted: json['isCompleted'] ?? false,
      isDeclined: json['isDeclined'] ?? false,
    );
  }

  String get details =>
      '$patientName (ID: $patientId)\nTime: $appointmentTime\n${_getStatus()}';

  String _getStatus() {
    if (isDeclined) return '(Cancelled)';
    if (isCompleted) return '(Completed)';
    return '(Scheduled)';
  }
}

import 'appointment.dart';

class DailyRecord {
  final String date;
  final List<Appointment> appointments;
  final String status;
  final DateTime timestamp;

  DailyRecord({
    required this.date,
    required this.appointments,
    required this.status,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'appointments': appointments.map((app) => app.toJson()).toList(),
      'status': status,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory DailyRecord.fromJson(Map<String, dynamic> json) {
    return DailyRecord(
      date: json['date'],
      appointments: (json['appointments'] as List)
          .map((app) => Appointment.fromJson(app))
          .toList(),
      status: json['status'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

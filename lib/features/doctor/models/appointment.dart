import 'patient.dart';

class Appointment {
  final String id;
  final String patientId;
  final bool isCompleted;
  final String notesImageUrl;
  final Patient patient;

  Appointment({
    required this.id,
    required this.patientId,
    required this.isCompleted,
    required this.notesImageUrl,
    required this.patient,
  });

  Appointment copyWith({
    String? id,
    String? patientId,
    bool? isCompleted,
    String? notesImageUrl,
    Patient? patient,
  }) {
    return Appointment(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      isCompleted: isCompleted ?? this.isCompleted,
      notesImageUrl: notesImageUrl ?? this.notesImageUrl,
      patient: patient ?? this.patient,
    );
  }
}

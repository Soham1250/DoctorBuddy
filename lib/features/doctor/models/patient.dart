class Patient {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String phoneNumber;
  final DateTime? lastVisit;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.phoneNumber,
    this.lastVisit,
  });

  // Mock data for testing
  static Patient getMockPatient(String patientId) {
    return Patient(
      id: patientId,
      name: 'John Doe',
      age: 35,
      gender: 'Male',
      phoneNumber: '123-456-7890',
      lastVisit: DateTime.now().subtract(const Duration(days: 30)),
    );
  }
}

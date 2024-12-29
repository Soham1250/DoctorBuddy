class Patient {
  final String id;
  final String name;
  final String gender;
  final int age;
  final DateTime lastVisited;
  final String detailedHistory;

  Patient({
    required this.id,
    required this.name,
    required this.gender,
    required this.age,
    required this.lastVisited,
    required this.detailedHistory,
  });

  // Mock data for testing
  static Patient getMockPatient(String id) {
    return Patient(
      id: id,
      name: 'John Doe',
      gender: 'Male',
      age: 45,
      lastVisited: DateTime(2024, 1, 15),
      detailedHistory: 'Regular checkups, No major conditions\n'
          '- Mild hypertension (controlled with medication)\n'
          '- Annual flu shots up to date\n'
          '- No known allergies',
    );
  }
}

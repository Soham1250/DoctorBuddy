import 'package:flutter/material.dart';
import '../../models/patient.dart';

class DoctorSearchPatientScreen extends StatefulWidget {
  const DoctorSearchPatientScreen({super.key});

  @override
  State<DoctorSearchPatientScreen> createState() =>
      _DoctorSearchPatientScreenState();
}

class _DoctorSearchPatientScreenState extends State<DoctorSearchPatientScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _patientFound = false;
  Patient? _patient;

  void _searchPatient() {
    if (_searchController.text.toLowerCase() == 'john doe') {
      setState(() {
        _patientFound = true;
        _patient = Patient.getMockPatient('PT001');
      });
    } else {
      setState(() {
        _patientFound = false;
        _patient = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Patient not found'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter patient name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchPatient,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onSubmitted: (_) => _searchPatient(),
            ),
            const SizedBox(height: 24),

            // Search Results
            if (_patientFound && _patient != null) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _patient!.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Divider(),
                      _buildDetailRow('Gender:', _patient!.gender),
                      _buildDetailRow('Age:', '${_patient!.age} years'),
                      const SizedBox(height: 8),
                      Text(
                        'Medical History:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/patient-details',
                              arguments: _patient!.id,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('View Full Details'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}

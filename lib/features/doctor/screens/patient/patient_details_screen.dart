// ignore_for_file: use_build_context_synchronously
import 'package:doctorbuddy/features/doctor/widgets/drawing/paged_drawing_canvas.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart'
    show DrawingController;
import '../../../../core/theme/app_colors.dart';
import '../../models/patient.dart';

class PatientDetailsScreen extends StatefulWidget {
  final Patient patient;
  final String appointmentId;
  final Function(String) onAppointmentComplete;

  const PatientDetailsScreen({
    super.key,
    required this.patient,
    required this.appointmentId,
    required this.onAppointmentComplete,
  });

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  final DrawingController _drawingController = DrawingController();
  bool _isSaving = false;

  void _completeAppointment() async {
    setState(() {
      _isSaving = true;
    });

    try {
      // Get the drawing as bytes
      final image = await _drawingController.getImageData();

      // TODO: Save the image to storage and get URL
      const imageUrl = "dummy_url";
      widget.onAppointmentComplete(imageUrl);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Appointment completed successfully'),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save notes'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.patient.name,
          style: const TextStyle(color: AppColors.primaryText),
        ),
      ),
      body: Column(
        children: [
          // Patient Details Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(
                bottom: BorderSide(color: AppColors.borderColor),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('Age', '${widget.patient.age} years'),
                _buildDetailRow('Gender', widget.patient.gender),
                _buildDetailRow('Phone', widget.patient.phoneNumber),
                if (widget.patient.lastVisit != null)
                  _buildDetailRow(
                    'Last Visit',
                    DateFormat('dd MMM yyyy').format(widget.patient.lastVisit!),
                  ),
              ],
            ),
          ),

          // Drawing Canvas Section
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.borderColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: PagedDrawingCanvas(
                  controller: _drawingController,
                  backgroundColor: Colors.white,
                  placeholder: 'Write notes here',
                ),
              ),
            ),
          ),

          // Done Button
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _completeAppointment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isSaving
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
          Text(
            value,
            style: const TextStyle(color: AppColors.secondaryText),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _drawingController.dispose();
    super.dispose();
  }
}

import '../models/daily_record.dart';
import '../models/appointment.dart';
import 'package:intl/intl.dart';

class DailyRecordService {
  static String getTodayDate() {
    final now = DateTime.now();
    return DateFormat('dd MMM yyyy').format(now);
  }

  static Future<void> saveDailyRecord(List<Appointment> appointments) async {
    final record = DailyRecord(
      date: getTodayDate(),
      appointments: appointments,
      status: 'completed',
      timestamp: DateTime.now(),
    );

    // TODO: Implement actual database storage

    // For now, we'll just print the record
    print('Saving daily record: ${record.toJson()}');
  }
}

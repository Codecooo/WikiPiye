import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String toReadableArticleDate(DateTime dateTime) {
    return DateFormat('d MMMM yyyy, HH:mm', 'id_ID').format(dateTime);
  }

  /// Format angka ringkas, mis. 12500 -> "12,5 rb".
  static String toCompactNumber(int value) {
    return NumberFormat.compact(locale: 'id_ID').format(value);
  }
}

import 'package:intl/intl.dart';

class Utils {
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
  static formatDateHour(DateTime date) => DateFormat.yMd().add_Hms().format(date);
}
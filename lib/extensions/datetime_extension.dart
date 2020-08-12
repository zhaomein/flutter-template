import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String format(format) {
    return DateFormat(format ?? 'dd/MM/yyyy').format(this);
  }
}
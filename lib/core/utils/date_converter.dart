// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class DateConverter {
  /// change dt to our dateFormat ---Sun Mon--- for Example
  static String changeDtToDateTimeDays(dt) {
    final formatter = DateFormat.E();
    var result = formatter
        .format(DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: true));

    return result;
  }

  /// change dt to our dateFormat ---10 aug--- for Example
  static String changeDtToDateTime(dt) {
    final formatter = DateFormat.MMMd();
    var result = formatter
        .format(DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: true));

    return result;
  }

  /// change dt to our dateFormat ---5:55 AM/PM--- for Example
  static String changeDtToDateTimeHour(dt, timeZone) {
    final formatter = DateFormat.jm();
    return formatter.format(DateTime.fromMillisecondsSinceEpoch(
        (dt * 1000) + timeZone * 1000,
        isUtc: true));
  }
}

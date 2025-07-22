
import 'package:netguard/common/common.dart';

extension DateExtensions on DateTime{
  bool sameDay(DateTime other){
    return year == other.year && month == other.month && day == other.day;
  }
  bool get isToday => sameDay(DateTime.now());

  /// Hour Minute Second (NO millis)
  String get hms => "${hour.nDigit(2)}:${minute.nDigit(2)}:${second.nDigit(2)}";

  String get date => "$year-${month.nDigit(2)}-${day.nDigit(2)}";

  String get noMs => "$date $hms";

}
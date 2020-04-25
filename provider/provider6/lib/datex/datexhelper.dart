import 'package:provider6/datex/datetime.dart' as DatextDateTime;

/*
  Datext Helper class.
 */
class DatexHelper {

  /// Convert utc string date time to Datex date time.
  static DatextDateTime.DateTime fromUTC(String utc) {

    DateTime dateTime = DateTime.parse(utc);

    // Extract fields for Datex Date Time.

    int day = dateTime.day;
    int hour  = dateTime.hour;
    int minute = dateTime.minute;
    int month = dateTime.month;
    int second = dateTime.second;
    int year = dateTime.year;
    double fractionalSecond = dateTime.millisecond.toDouble();
    int timezone = 0;

    DatextDateTime.DateTime datexDateTime = DatextDateTime.DateTime(day:day,
        fractionalSecond:fractionalSecond,
        hour: hour,
        minute: minute,
        month: month, second: second, timezone: timezone, year: year);

      return datexDateTime;
  }
}
class DateTime {
  int day;
  double fractionalSecond;
  int hour;
  int minute;
  int month;
  int second;
  int timezone;
  int year;

  DateTime({
    this.day,
    this.fractionalSecond,
    this.hour,
    this.minute,
    this.month,
    this.second,
    this.timezone,
    this.year,
  });

  factory DateTime.fromJson(Map<String, dynamic> json) {
    DateTime dateTime;
    if (json != null) {
      dateTime = DateTime(
        day: json["day"] == null ? null : json["day"],
        fractionalSecond: json["fractionalSecond"] == null
            ? null
            : json["fractionalSecond"].toDouble(),
        hour: json["hour"] == null ? null : json["hour"],
        minute: json["minute"] == null ? null : json["minute"],
        month: json["month"] == null ? null : json["month"],
        second: json["second"] == null ? null : json["second"],
        timezone: json["timezone"] == null ? null : json["timezone"],
        year: json["year"] == null ? null : json["year"],
      );
    }
    return dateTime;
  }
  
  Map<String, dynamic> toJson() => {
    "day": day == null ? null : day,
    "fractionalSecond": fractionalSecond == null ? null : fractionalSecond,
    "hour": hour == null ? null : hour,
    "minute": minute == null ? null : minute,
    "month": month == null ? null : month,
    "second": second == null ? null : second,
    "timezone": timezone == null ? null : timezone,
    "year": year == null ? null : year,
  };
}
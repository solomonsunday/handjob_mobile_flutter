import 'package:intl/intl.dart';

dateToIso8601String(String str) {
  DateFormat df = DateFormat("dd-MMM-yyyy");
  DateTime input = df.parse(str);
  return input.toIso8601String();
}

fromIsoToDateTime(String str) {
  return DateTime.parse(str);
}

fromIsoToDateTimeToDefaultFormat(DateTime dt) {
  DateFormat df = DateFormat("dd-MMM-yyyy");

  return df.format(dt);
}

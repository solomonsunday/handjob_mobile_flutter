import 'dart:io';

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

//file size
double getFileSizeInMB(File file) {
  int sizeInBytes = file.lengthSync();
  double sizeInMb = sizeInBytes / (1024 * 1024);
  return sizeInMb;
}

String getTimeDiff(String dt) {
  DateTime dt1 = DateTime.parse(dt);
  DateTime dt2 = DateTime.now();

  Duration diff = dt1.difference(dt2);

  if (diff.inDays > 0) {
    return '${diff.inDays}d';
  }
  if (diff.inHours > 0) {
    return '${diff.inHours}h';
  }
  if (diff.inMinutes > 0) {
    return '${diff.inMinutes}m';
  }
  if (diff.inSeconds > 0) {
    return '${diff.inSeconds}s';
  }

  return 'just now';
}

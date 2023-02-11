import 'dart:io';

import 'package:intl/intl.dart';

toDefaultDtFormat(String str) {
  DateFormat df = DateFormat("dd-MMM-yyyy");
  DateTime input = df.parse(str);
  return input;
}

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

  Duration diff = dt2.difference(dt1);

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

String getTimeAgoDiff(String dt) {
  DateTime dt1 = DateTime.parse(dt);
  DateTime dt2 = DateTime.now();

  Duration diff = dt2.difference(dt1);

  if (diff.inDays > 0) {
    return '${diff.inDays} ${diff.inDays > 0 ? 'days' : 'day'} ago';
  }
  if (diff.inHours > 0) {
    return '${diff.inHours} ${diff.inHours > 0 ? 'hours' : 'hour'} ago';
  }
  if (diff.inMinutes > 0) {
    return '${diff.inMinutes} ${diff.inMinutes > 0 ? 'minutes' : 'minute'} ago';
  }
  if (diff.inSeconds > 0) {
    return '${diff.inSeconds} ${diff.inSeconds > 0 ? 'seconds' : 'second'} ago';
  }

  return 'just now';
}

import 'package:timeago/timeago.dart' as timeago;

humanizeDate(DateTime dt) {
  final dtAgo = DateTime.now().subtract(Duration(
    days: dt.day,
    hours: dt.hour,
    minutes: dt.minute,
    seconds: dt.second,
  ));
  return timeago.format(dtAgo);
}

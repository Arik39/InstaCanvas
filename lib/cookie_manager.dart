void set(
  String key,
  String value, {
  DateTime? expires,
  Duration? maxAge,
  String? path,
  String? domain,
  bool? secure,
}) {
  if (maxAge != null) expires = DateTime.now().add(maxAge);

  var cookie = ([
    Uri.encodeComponent(key),
    '=',
    Uri.encodeComponent(value),
    expires != null ? '; expires=${formatDate(expires)}' : '',
    path != null ? '; path=$path' : '',
    domain != null ? '; domain$domain' : '',
    secure != null && secure == true ? '; secure' : ''
  ].join(''));
}

const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

String _pad(int number) => '$number'.padLeft(2, '0');

String formatDate(DateTime date) {
  date = date.toUtc();
  final weekday = _weekdays[date.weekday - 1];
  final month = _months[date.month - 1];
  return '$weekday, ${_pad(date.day)} $month ${date.year} ${_pad(date.hour)}:${_pad(date.minute)}:${_pad(date.second)} UTC';
}

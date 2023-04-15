import 'group.dart';

class Record extends Group {
  DateTime date;
  int number;
  int? numberInWeek;
  String format = '&yy-&n1(week&ww-&n2)';

  Record({required this.date, this.number = 1, this.numberInWeek});

  @override
  String getText() {
    return '${date.year}-001(week${_getWeekNumber(date).toString().padLeft(3, '0')}-1)';
  }

  int _getWeekNumber(DateTime date) {
    int days = date.day;
    for (int i = 1; i <= date.month - 1; i++) {
      days += DateTime(date.year, i + 1, 0).day;
    }
    return days ~/ 7 + 1;
  }
}

enum Parameter {
  year('yy'),
  month('mm'),
  day('dd'),
  week('ww'),
  number('n1'),
  numberInWeek('n2'),
  ;

  final String regex;

  const Parameter(this.regex);
}

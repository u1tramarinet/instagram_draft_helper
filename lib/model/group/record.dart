import 'group.dart';

class Record extends Group {
  DateTime date;
  int number;
  int? numberInWeek;
  String format = '&yy-&n1(week&ww-&n2)';

  Record({required this.date, this.number = 1, this.numberInWeek});

  @override
  String getText() {
    // TODO: implement getText
    throw UnimplementedError();
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

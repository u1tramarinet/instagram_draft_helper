import '../part/keyword.dart';
import 'list_group.dart';

class Keywords extends ListGroup<Keyword> {
  @override
  String getText() {
    return getAll().map((keyword) => keyword.format()).toList().join('\n');
  }
}

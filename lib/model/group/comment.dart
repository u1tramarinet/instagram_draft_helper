import 'group.dart';

class Comment extends Group {
  String _content = '';

  void updateContent(String comment) {
    _content = comment;
  }

  String getContent() {
    return _content;
  }

  @override
  String getText() {
    return _content;
  }
}

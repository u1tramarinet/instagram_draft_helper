import 'package:instagram_draft_helper/model/group/countable.dart';

import 'group.dart';

class Comment extends Group with Countable {
  String _content = '';

  Comment updateContent(String comment) {
    _content = comment;
    return this;
  }

  String getContent() {
    return _content;
  }

  @override
  int getCount() {
    return _content.length;
  }

  @override
  String getText() {
    return _content;
  }
}

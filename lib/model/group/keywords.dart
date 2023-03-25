import '../part/keyword.dart';
import 'group.dart';

class Keywords extends Group {
  final List<Keyword> _keyword = [];

  void addKeyword(Keyword keyword) {
    _keyword.add(keyword);
  }

  void addKeywords(List<Keyword> keywords) {
    _keyword.addAll(keywords);
  }

  void removeKeyword(Keyword keyword) {
    _keyword.remove(keyword);
  }

  void clearKeywords() {
    _keyword.clear();
  }

  @override
  String getText() {
    return _keyword.map((keyword) => keyword.format()).toList().join('\n');
  }
}

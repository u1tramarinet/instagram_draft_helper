import 'dart:math';

import 'package:collection/collection.dart';

import 'part/keyword.dart';
import 'part/tag.dart';

class KeywordRepository {
  static const KeywordRepository _instance = KeywordRepository._();

  static final List<Keyword> _keywords = [];

  factory KeywordRepository() {
    return _instance;
  }

  const KeywordRepository._();

  bool register(Keyword keyword) {
    if (contains(keyword.name)) {
      return false;
    }
    if (keyword.tags.any((tag) => tag.isUndefined())) {
      return false;
    }
    int id = _keywords.fold(
            0, (previousValue, element) => max(previousValue, element.id)) +
        1;
    _keywords.add(keyword.copyWith(id: id));
    return true;
  }

  List<Keyword> getAll() {
    return [..._keywords];
  }

  Keyword? get(int id) {
    return _keywords.firstWhereOrNull((tag) => tag.id == id);
  }

  Keyword? findByName(String name) {
    return _keywords.firstWhereOrNull((tag) => tag.name == name);
  }

  List<Keyword> findByTag(Tag tag) {
    return _keywords.where((keyword) => keyword.tags.contains(tag)).toList();
  }

  bool unregister(int id) {
    if (get(id) == null) {
      return false;
    }
    _keywords.removeWhere((tag) => tag.id == id);
    return true;
  }

  bool contains(String name) {
    return _keywords.any((keyword) => keyword.name == name);
  }
}

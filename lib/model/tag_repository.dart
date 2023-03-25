import 'dart:math';

import 'package:collection/collection.dart';

import 'part/tag.dart';

class TagRepository {
  static const TagRepository _instance = TagRepository._();

  static final List<Tag> _tags = [];

  factory TagRepository() {
    return _instance;
  }

  const TagRepository._();

  bool register(Tag tag) {
    if (contains(tag.name)) {
      return false;
    }
    int id = _tags.fold(
            0, (previousValue, element) => max(previousValue, element.id)) +
        1;
    _tags.add(tag.copyWith(id: id));
    return true;
  }

  List<Tag> getAll() {
    return [..._tags];
  }

  Tag? get(int id) {
    return _tags.firstWhereOrNull((tag) => tag.id == id);
  }

  Tag? findByName(String name) {
    return _tags.firstWhereOrNull((tag) => tag.name == name);
  }

  bool unregister(int id) {
    if (get(id) == null) {
      return false;
    }
    _tags.removeWhere((tag) => tag.id == id);
    return true;
  }

  bool contains(String name) {
    return _tags.any((tag) => tag.name == name);
  }
}

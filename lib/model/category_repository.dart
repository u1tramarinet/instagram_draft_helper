import 'dart:math';

import 'package:collection/collection.dart';

import 'part/category.dart';

class CategoryRepository {
  static const CategoryRepository _instance = CategoryRepository._();

  static final List<Category> _categories = [];

  factory CategoryRepository() {
    return _instance;
  }

  const CategoryRepository._();

  bool register(Category category) {
    if (contains(category.name)) {
      return false;
    }
    int id = _categories.fold(
            0, (previousValue, element) => max(previousValue, element.id)) +
        1;
    _categories.add(category.copyWith(id: id));
    return true;
  }

  List<Category> getAll() {
    return [..._categories];
  }

  Category? get(int id) {
    return _categories.firstWhereOrNull((tag) => tag.id == id);
  }

  bool unregister(int id) {
    if (get(id) == null) {
      return false;
    }
    _categories.removeWhere((tag) => tag.id == id);
    return true;
  }

  bool contains(String name) {
    return _categories.any((tag) => tag.name == name);
  }
}

import 'dart:math';

import 'package:collection/collection.dart';
import 'package:instagram_draft_helper/model/part/identifiable.dart';
import 'package:instagram_draft_helper/model/part/keyword.dart';

import 'part/category.dart';
import 'part/product.dart';

class ProductRepository {
  static const ProductRepository _instance = ProductRepository._();

  static final List<Product> _products = [];

  factory ProductRepository() {
    return _instance;
  }

  const ProductRepository._();

  bool register(Product product) {
    if (contains(product.name)) {
      return false;
    }
    if (product.tags.any((tag) => tag.isUndefined())) {
      return false;
    }
    if (product.category != null && product.category!.isUndefined()) {
      return false;
    }
    if (product.maker != null && product.maker!.isUndefined()) {
      return false;
    }
    if (product.brand != null && product.brand!.isUndefined()) {
      return false;
    }
    int id = _products.fold(
            0, (previousValue, element) => max(previousValue, element.id)) +
        1;
    _products.add(product.copyWith(id: id));
    return true;
  }

  List<Product> getAll() {
    return [..._products];
  }

  Product? get(int id) {
    return _products.firstWhereOrNull((tag) => tag.id == id);
  }

  Product? findByName(String name) {
    return _products.firstWhereOrNull((tag) => tag.name == name);
  }

  List<Product> findByCategory(Category category) {
    return _findByIdentifiable(category, (product) => product.category);
  }

  List<Product> findByMaker(Keyword maker) {
    return _findByIdentifiable(maker, (product) => product.maker);
  }

  List<Product> findByBrand(Keyword brand) {
    return _findByIdentifiable(brand, (product) => product.brand);
  }

  List<Product> _findByIdentifiable(
      Identifiable other, Identifiable? Function(Product) f) {
    return _products.where((product) => other.isSameId(f(product))).toList();
  }

  bool unregister(int id) {
    if (get(id) == null) {
      return false;
    }
    _products.removeWhere((tag) => tag.id == id);
    return true;
  }

  bool contains(String name) {
    return _products.any((keyword) => keyword.name == name);
  }
}

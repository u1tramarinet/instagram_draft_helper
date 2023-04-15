import 'countable.dart';
import 'group.dart';
import '../part/identifiable.dart';

abstract class ListGroup<T extends Identifiable> extends Group with Countable {
  final List<T> _items = [];

  List<T> getAll() {
    return [..._items];
  }

  void add(T item, [bool Function(T, T)? compareFunc]) {
    Function(T, T) compare = compareFunc ?? (T a, T b) => a.isSameId(b);
    if (_items.every((e) => !compare(e, item))) {
      _items.add(item);
    }
  }

  void addAll(List<T> items, [bool Function(T, T)? compareFunc]) {
    Function(T, T) compare = compareFunc ?? (T a, T b) => a.isSameId(b);
    items =
        items.where((item) => _items.every((e) => compare(item, e))).toList();
    _items.addAll(items);
  }

  void remove(T item, [bool Function(T, T)? compareFunc]) {
    Function(T, T) compare = compareFunc ?? (T a, T b) => a.isSameId(b);
    _items.removeWhere((e) => compare(e, item));
  }

  void clear() {
    _items.clear();
  }

  @override
  int getCount() {
    return _items.length;
  }
}

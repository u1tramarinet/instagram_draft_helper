import '../part/keyword.dart';
import '../part/product.dart';
import 'group.dart';

class Products extends Group {
  final List<Product> _products = [];

  void addProduct(Product product) {
    _products.add(product);
  }

  void addProducts(List<Product> products) {
    _products.addAll(products);
  }

  void removeProduct(Product product) {
    _products.remove(product);
  }

  void clearProducts() {
    _products.clear();
  }

  @override
  String getText() {
    List<Product> categorized =
        _products.where((product) => product.category != null).toList();
    List<Product> uncategorized =
        _products.where((product) => product.category == null).toList();
    String text = '';
    for (Product product in categorized) {
      text += '${product.category!.name}: ${product.format()}';
    }
    if (categorized.isNotEmpty && uncategorized.isNotEmpty) {
      text += '\n';
    }
    for (Product product in uncategorized) {
      text += '${product.category!.name}: ${product.format()}';
    }
    Set<Keyword> makers = _products
        .where((product) => product.maker != null)
        .map((product) => product.maker!)
        .toSet();
    Set<Keyword> brands = _products
        .where((product) => product.brand != null)
        .map((product) => product.brand!)
        .toSet();
    if ((categorized.isNotEmpty || uncategorized.isNotEmpty) &&
        (makers.isNotEmpty || brands.isNotEmpty)) {
      text += '\n';
    }
    for (Keyword maker in makers) {
      text += maker.format();
    }
    for (Keyword brand in brands) {
      text += brand.format();
    }
    return text;
  }
}

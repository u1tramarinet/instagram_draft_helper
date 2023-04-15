import '../part/category.dart';
import '../part/keyword.dart';
import '../part/product.dart';
import 'list_group.dart';

const Category cameras = Category(name: 'カメラ');
const Category lenses = Category(name: 'レンズ');
const Category editors = Category(name: 'エディタ');

class Products extends ListGroup<Product> {
  List<Category> getCategories() {
    return [cameras, lenses, editors];
  }

  List<Product> getProducts(Category category) {
    return getAll().where((product) => product.category == category).toList();
  }

  @override
  String getText() {
    List<Product> products = getAll();
    List<Product> categorized =
        products.where((product) => product.category != null).toList();
    List<Product> uncategorized =
        products.where((product) => product.category == null).toList();
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
    Set<Keyword> makers = products
        .where((product) => product.maker != null)
        .map((product) => product.maker!)
        .toSet();
    Set<Keyword> brands = products
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

import 'entity.dart';

class Product {
  final String name;
  final Entity? maker;
  final Entity? brand;

  const Product({required this.name, this.maker, this.brand});
}

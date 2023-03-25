import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:instagram_draft_helper/model/part/tag.dart';

import 'identifiable.dart';
import 'category.dart';
import 'keyword.dart';

part 'product.freezed.dart';

@freezed
class Product extends Identifiable with _$Product {
  const Product._();

  const factory Product({
    @Default(Identifiable.undefined) int id,
    required String name,
    @Default([]) List<Tag> tags,
    Category? category,
    Keyword? maker,
    Keyword? brand,
  }) = _Product;

  String format([String separator = '']) {
    return '$name ${tags.map((e) => '#${e.name}').toList().join(separator)}';
  }
}

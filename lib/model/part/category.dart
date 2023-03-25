import 'package:freezed_annotation/freezed_annotation.dart';

import 'identifiable.dart';

part 'category.freezed.dart';

@freezed
class Category extends Identifiable with _$Category {
  const Category._();

  const factory Category({
    @Default(Identifiable.undefined) int id,
    required String name,
  }) = _Category;
}

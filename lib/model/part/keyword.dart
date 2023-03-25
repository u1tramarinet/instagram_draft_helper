import 'package:freezed_annotation/freezed_annotation.dart';

import 'identifiable.dart';
import 'tag.dart';

part 'keyword.freezed.dart';

@freezed
class Keyword extends Identifiable with _$Keyword {
  const Keyword._();

  const factory Keyword({
    @Default(Identifiable.undefined) int id,
    required String name,
    @Default([]) List<Tag> tags,
  }) = _Keyword;

  String format([String separator = '']) {
    return tags.map((tag) => tag.format()).toList().join(separator);
  }
}

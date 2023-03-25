import 'package:freezed_annotation/freezed_annotation.dart';

import 'identifiable.dart';

part 'tag.freezed.dart';

@freezed
class Tag extends Identifiable with _$Tag {
  const Tag._();

  const factory Tag({
    @Default(Identifiable.undefined) int id,
    required String name,
  }) = _Tag;

  String format() {
    return '#$name ';
  }
}

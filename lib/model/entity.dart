import 'tag.dart';

class Entity {
  final String keyword;
  final List<Tag> _tags = [];

  Entity({required this.keyword, List<Tag> tags = const []}) {
    _tags.addAll(tags);
  }

  void addTag(Tag tag) {
    _tags.add(tag);
  }

  void addTags(List<Tag> tags) {
    _tags.addAll(tags);
  }

  List<Tag> getTags() {
    return [..._tags];
  }
}

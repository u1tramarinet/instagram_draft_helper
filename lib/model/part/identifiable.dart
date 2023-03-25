abstract class Identifiable {
  static const int undefined = -1;

  const Identifiable();

  int get id;

  bool isSameId(Identifiable? other) {
    return (runtimeType == other.runtimeType) && (id == other!.id);
  }

  bool isUndefined() {
    return (id == undefined);
  }
}

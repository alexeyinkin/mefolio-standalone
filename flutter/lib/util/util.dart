extension AlternateWith<T> on Iterable<T> {
  List<T> alternateWith(T separator) {
    return expand((item) sync* {
      yield separator;
      yield item;
    }).skip(1).toList(growable: false);
  }
}

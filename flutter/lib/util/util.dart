extension AlternateWith<T> on Iterable<T> {
  List<T> alternateWith(T separator) {
    return expand((item) sync* {
      yield separator;
      yield item;
    }).skip(1).toList(growable: false);
  }
}

String formatDate(DateTime dateTime) {
  // TODO: Localization.
  final month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"][dateTime.month - 1];
  return "$month ${dateTime.day}, ${dateTime.year}";
}

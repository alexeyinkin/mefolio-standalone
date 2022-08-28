class ExternalUrl {
  final Uri uri;
  final String? title;

  const ExternalUrl({
    required this.uri,
    required this.title,
  });

  factory ExternalUrl.fromMap(Map<String, dynamic> map) {
    return ExternalUrl(
      uri: Uri.parse(map['url']),
      title: map['title'],
    );
  }

  static List<ExternalUrl> fromMaps(List maps) {
    return maps
        .cast<Map<String, dynamic>>()
        .map<ExternalUrl>(ExternalUrl.fromMap)
        .toList(growable: false);
  }
}

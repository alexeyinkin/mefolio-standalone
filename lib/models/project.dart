import 'package:model_interfaces/model_interfaces.dart';

import 'external_url.dart';

class Project implements WithIdTitle<String> {
  @override
  final String id;

  @override
  final String title;

  final String description;
  final int? year;
  final List<ExternalUrl> urls;
  final String imageUrl;
  final List<String> tags;
  final DateTime? dateTime;
  final String body;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.year,
    required this.urls,
    required this.imageUrl,
    required this.tags,
    required this.dateTime,
    required this.body,
  });

  // TODO: Safe parsing. Return null and print error.
  factory Project.fromIdAndMap(String id, Map<String, dynamic> map) {
    return Project(
      id: id,
      title: map['title'],
      description: map['description'],
      year: map['year'],
      urls: ExternalUrl.fromMaps(map['urls'] ?? []),
      imageUrl: map['imageUrl'],
      tags: map['tags'].cast<String>(),
      dateTime: map['dateTime']?.toDate(),
      body: map['body'] ?? '',
    );
  }
}

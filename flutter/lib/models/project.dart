import 'package:model_interfaces/model_interfaces.dart';

import 'external_url.dart';
import 'project_view.dart';

class Project implements WithIdTitle<String> {
  @override
  final String id;

  @override
  final String title;

  final String body;
  final DateTime? dateTimeEnd;
  final DateTime? dateTimeRelease;
  final DateTime? dateTimeStart;
  final String description;
  final String imageUrl;
  final String? role;
  final List<String> tags;
  final List<ExternalUrl> urls;
  final ProjectView view;
  final int? year;

  Project({
    required this.body,
    required this.dateTimeEnd,
    required this.dateTimeRelease,
    required this.dateTimeStart,
    required this.description,
    required this.id,
    required this.imageUrl,
    required this.role,
    required this.tags,
    required this.title,
    required this.urls,
    required this.view,
    required this.year,
  });

  // TODO: Safe parsing. Return null and print error.
  factory Project.fromIdAndMap(String id, Map<String, dynamic> map) {
    return Project(
      body: map['body'] ?? '',
      dateTimeEnd: map['dateTimeEnd']?.toDate(),
      dateTimeRelease: map['dateTimeRelease']?.toDate(),
      dateTimeStart: map['dateTimeStart']?.toDate(),
      description: map['description'],
      id: id,
      imageUrl: map['imageUrl'],
      role: map['role'],
      tags: map['tags'].cast<String>(),
      title: map['title'],
      urls: ExternalUrl.fromMaps(map['urls'] ?? []),
      view: ProjectView.fromMapOrNull(map['view']),
      year: map['year'],
    );
  }
}

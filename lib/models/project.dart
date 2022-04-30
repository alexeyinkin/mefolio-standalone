import 'package:model_interfaces/model_interfaces.dart';

class Project implements WithIdTitle<String> {
  @override
  final String id;

  @override
  final String title;

  final int year;
  final String url;

  Project({
    required this.id,
    required this.title,
    required this.year,
    required this.url,
  });

  factory Project.fromIdAndMap(String id, Map<String, dynamic> map) {
    return Project(
      id: id,
      title: map['title'],
      year: map['year'],
      url: map['url'],
    );
  }
}

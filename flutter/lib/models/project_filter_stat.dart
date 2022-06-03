import 'package:model_interfaces/model_interfaces.dart';

import 'project_filter_stat_leaf.dart';

class ProjectFilterStat implements WithId<String> {
  @override
  final String id;
  final int count;
  final Map<String, ProjectFilterStatLeaf> tagsAnd;
  final Map<int, ProjectFilterStatLeaf> year;

  ProjectFilterStat({
    required this.id,
    required this.count,
    required this.tagsAnd,
    required this.year,
  });

  factory ProjectFilterStat.fromIdAndMap(String id, Map<String, dynamic> map) {
    return ProjectFilterStat(
      id: id,
      count: map['count'] ?? 0,
      tagsAnd: ProjectFilterStatLeaf.fromStringMaps(map['tagsAnd']),
      year: ProjectFilterStatLeaf.fromIntMaps(map['year']),
    );
  }
}

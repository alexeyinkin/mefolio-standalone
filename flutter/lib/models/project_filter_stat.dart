import 'package:model_interfaces/model_interfaces.dart';

class ProjectFilterStat implements WithId<String> {
  @override
  final String id;
  final int count;

  ProjectFilterStat({
    required this.id,
    required this.count,
  });

  factory ProjectFilterStat.fromIdAndMap(String id, Map<String, dynamic> map) {
    return ProjectFilterStat(
      id: id,
      count: map['count'] ?? 0,
    );
  }
}

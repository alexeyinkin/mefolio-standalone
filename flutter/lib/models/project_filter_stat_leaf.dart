class ProjectFilterStatLeaf {
  final int count;

  ProjectFilterStatLeaf({
    required this.count,
  });

  factory ProjectFilterStatLeaf.fromMap(Map<String, dynamic> map) {
    return ProjectFilterStatLeaf(
      count: map['count'] ?? 0,
    );
  }

  static Map<String, ProjectFilterStatLeaf> fromStringMaps(Map<String, dynamic> map) {
    return map.map(
      (key, value) => MapEntry(key, ProjectFilterStatLeaf.fromMap(value)),
    );
  }

  static Map<int, ProjectFilterStatLeaf> fromIntMaps(Map<String, dynamic> map) {
    return map.map(
      (key, value) => MapEntry(int.parse(key), ProjectFilterStatLeaf.fromMap(value)),
    );
  }
}

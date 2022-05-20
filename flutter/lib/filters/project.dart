import 'package:model_fetch/model_fetch.dart';

class ProjectFilter extends AbstractFilter {
  final List<String>? tagsAnd;
  final int? year;

  bool get isEmpty {
    if (tagsAnd != null) return false;
    if (year != null) return false;
    return true;
  }

  const ProjectFilter({
    this.tagsAnd,
    this.year,
  });

  static ProjectFilter fromMap(Map<String, dynamic> map) {
    return ProjectFilter(
      tagsAnd: _parseTagsAnd(map),
      year: _parseYear(map),
    );
  }

  static int? _parseYear(Map<String, dynamic> map) {
    final year = map['year'];
    if (year == null) return null;
    if (year is int) return year;
    return int.tryParse('$year');
  }

  static List<String>? _parseTagsAnd(Map<String, dynamic> map) {
    return map['tags']?.cast<String>();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      if (tagsAnd != null) "tags": tagsAnd,
      if (year != null) "year": year,
    };
  }
}

import 'package:collection/collection.dart';
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

  String get id {
    final parts = <String>[];

    for (final tag in (tagsAnd ?? <String>[]).sorted(Comparable.compare)) {
      parts.add('t$tag');
    }

    if (year != null) {
      parts.add('y$year');
    }

    return 'f_${parts.join('_')}';
  }

  ProjectFilter removeTagAnd(String tag) {
    if (tagsAnd == null) return this;

    final newTagsAnd = tagsAnd!.where((t) => t != tag).toList(growable: false);
    return withTagsAnd(newTagsAnd.isEmpty ? null : newTagsAnd);
  }

  ProjectFilter andTag(String tag) {
    if ((tagsAnd ?? []).contains(tag)) return this;

    final newTagsAnd = [...(tagsAnd ?? <String>[]), tag];
    return withTagsAnd(newTagsAnd);
  }

  ProjectFilter withTagsAnd(List<String>? tagsAnd) {
    return ProjectFilter(
      tagsAnd: tagsAnd,
      year: year,
    );
  }
}

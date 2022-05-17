import 'package:model_fetch/model_fetch.dart';

class ProjectFilter extends AbstractFilter {
  final int? year;
  final List<String>? tagsOr;

  const ProjectFilter({
    this.year,
    this.tagsOr,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      if (year != null) "year": year,
      if (tagsOr != null) "tagsOr": tagsOr,
    };
  }
}

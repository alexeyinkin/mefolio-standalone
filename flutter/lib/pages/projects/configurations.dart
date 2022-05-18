import 'package:app_state/app_state.dart';
import 'package:flutter/widgets.dart';

import 'page.dart';
import '../../filters/project.dart';
import '../../router/tab_enum.dart';

class ProjectsPageConfiguration extends PageConfiguration {
  static const _location = '/projects';

  final ProjectFilter filter;

  ProjectsPageConfiguration({
    required this.filter,
  }) : super(
    key: ProjectsPage.formatKey(filter: filter),
    factoryKey: ProjectsPage.factoryKey,
  );

  @override
  RouteInformation restoreRouteInformation() {
    final params = _getQueryStringParams();
    final uri = Uri(
      path: _location,
      queryParameters: params.isEmpty ? null : params,
    );
    final str = uri.toString();

    return RouteInformation(location: str);
  }

  Map<String, String> _getQueryStringParams() {
    final result = <String, String>{};

    if (filter.tagsAnd != null) result['tags'] = filter.tagsAnd!.join(' ');

    final year = filter.year;
    if (year != null) result['year'] = '$year';

    return result;
  }

  @override
  Map<String, dynamic> get state => filter.toJson();

  static ProjectsPageConfiguration? tryParse(RouteInformation ri) {
    final uri = Uri.parse(ri.location ?? '');
    if (uri.path != _location) return null;

    return ProjectsPageConfiguration(
      filter: _stringMapToProjectFilter(uri.queryParameters),
    );
  }

  static ProjectFilter _stringMapToProjectFilter(Map<String, String> map) {
    final tagsString = map['tags'] ?? '';

    return ProjectFilter(
      year: int.tryParse(map['year'] ?? ''),
      tagsAnd: tagsString == '' ? null : tagsString.split(' '),
    );
  }

  @override
  String get defaultStackKey => TabEnum.projects.name;
}

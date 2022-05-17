import 'package:app_state/app_state.dart';
import 'package:flutter/widgets.dart';

import '../../filters/project.dart';
import '../../router/tab_enum.dart';
import '../projects/configurations.dart';
import 'page.dart';

class ProjectPageConfiguration extends PageConfiguration {
  final String id;

  static final _regExp = RegExp(r'^/projects/([-a-zA-Z0-9.]+)$');

  ProjectPageConfiguration({
    required this.id,
  }) : super(
          key: ProjectPage.formatKey(id: id),
          factoryKey: ProjectPage.factoryKey,
          state: {'id': id},
        );

  @override
  RouteInformation restoreRouteInformation() {
    return RouteInformation(
      location: '/projects/$id',
    );
  }

  static ProjectPageConfiguration? tryParse(RouteInformation ri) {
    final matches = _regExp.firstMatch(ri.location ?? '');
    if (matches == null) return null;

    final id = matches[1];

    if (id == null) {
      return null; // Will never get here with present _regExp.
    }

    return ProjectPageConfiguration(
      id: id,
    );
  }

  @override
  PageStackConfiguration get defaultStackConfiguration {
    return PageStackConfiguration(
      pageConfigurations: [
        ProjectsPageConfiguration(filter: const ProjectFilter()),
        this,
      ],
    );
  }

  @override
  String get defaultStackKey => TabEnum.projects.name;
}

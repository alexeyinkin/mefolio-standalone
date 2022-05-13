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
    return const RouteInformation(location: _location);
  }

  @override
  String get defaultStackKey => TabEnum.projects.name;
}

import 'package:app_state/app_state.dart';
import 'package:flutter/widgets.dart';

import 'page.dart';
import '../../router/tab_enum.dart';

class ProjectsPageConfiguration extends PageConfiguration {
  static const _location = '/projects';

  const ProjectsPageConfiguration() : super(key: ProjectsPage.factoryKey);

  @override
  RouteInformation restoreRouteInformation() {
    return const RouteInformation(location: _location);
  }

  @override
  String get defaultStackKey => TabEnum.projects.name;
}

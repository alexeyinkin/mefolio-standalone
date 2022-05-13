import 'package:app_state/app_state.dart';
import 'package:flutter/widgets.dart';

import '../filters/project.dart';
import '../pages/project/configurations.dart';
import '../pages/projects/configurations.dart';

class MyRouteInformationParser extends PageStacksRouteInformationParser {
  @override
  Future<PageStacksConfiguration> parseRouteInformation(RouteInformation ri) async {
    return _parseTopPageConfiguration(ri).defaultStacksConfiguration;
  }

  PageConfiguration _parseTopPageConfiguration(RouteInformation ri) {
    return
        ProjectPageConfiguration.tryParse(ri) ??

        // The default page if nothing worked.
        ProjectsPageConfiguration(filter: const ProjectFilter());
  }
}

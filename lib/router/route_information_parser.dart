import 'package:app_state/app_state.dart';
import 'package:flutter/widgets.dart';

import '../pages/projects/configurations.dart';

class MyRouteInformationParser extends PageStacksRouteInformationParser {
  @override
  Future<PageStacksConfiguration> parseRouteInformation(RouteInformation ri) async {
    return _parseTopPageConfiguration(ri).defaultStacksConfiguration;
  }

  PageConfiguration _parseTopPageConfiguration(RouteInformation ri) {
    return
        // The default page if nothing worked.
        const ProjectsPageConfiguration();
  }
}

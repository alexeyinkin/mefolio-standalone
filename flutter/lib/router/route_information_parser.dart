import 'package:app_state/app_state.dart';
import 'package:flutter/widgets.dart';

import '../filters/project.dart';
import '../pages/contact/path.dart';
import '../pages/project/path.dart';
import '../pages/projects/path.dart';

class MyRouteInformationParser extends PageStacksRouteInformationParser {
  @override
  Future<PagePath> parsePagePath(RouteInformation ri) async {
    return
        ContactPath.tryParse(ri) ??
        ProjectPath.tryParse(ri) ??
        ProjectsPath.tryParse(ri) ??

        // The default page if nothing worked.
        ProjectsPath(filter: const ProjectFilter());
  }
}

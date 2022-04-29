import 'package:app_state/app_state.dart';

import 'configurations.dart';

class ProjectsPageBloc extends PageBloc<ProjectsPageConfiguration> {
  @override
  ProjectsPageConfiguration getConfiguration() {
    return const ProjectsPageConfiguration();
  }
}

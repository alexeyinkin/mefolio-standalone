import 'package:app_state/app_state.dart';

import '../../filters/project.dart';
import 'configurations.dart';

class ProjectsPageBloc extends PageBloc<ProjectsPageConfiguration> {
  final ProjectFilter filter;

  ProjectsPageBloc({
    required this.filter,
  });

  @override
  ProjectsPageConfiguration getConfiguration() {
    return ProjectsPageConfiguration(filter: filter);
  }
}

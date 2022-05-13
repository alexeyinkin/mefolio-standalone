import 'package:app_state/app_state.dart';
import 'package:flutter/foundation.dart';

import '../../filters/project.dart';
import 'bloc.dart';
import 'configurations.dart';
import 'screen.dart';

class ProjectsPage
    extends BlocMaterialPage<ProjectsPageConfiguration, ProjectsPageBloc> {
  static const factoryKey = 'ProjectsPage';

  ProjectsPage({
    required ProjectFilter filter,
  }) : super(
          key: ValueKey(formatKey(filter: filter)),
          factoryKey: factoryKey,
          bloc: ProjectsPageBloc(filter: filter),
          createScreen: (b) => ProjectsScreen(bloc: b),
        );

  static String formatKey({required ProjectFilter filter}) {
    return '${factoryKey}_${filter.hash}';
  }
}

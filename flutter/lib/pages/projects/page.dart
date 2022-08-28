import 'package:app_state/app_state.dart';
import 'package:flutter/foundation.dart';

import '../../filters/project.dart';
import 'bloc.dart';
import 'screen.dart';

class ProjectsPage extends StatefulMaterialPage<void, ProjectsPageBloc> {
  static const classFactoryKey = 'ProjectsPage';

  ProjectsPage({
    required ProjectFilter initialFilter,
  }) : super(
          // TODO: Just unique keys since filter can now be replaced.
          key: ValueKey(formatKey(filter: initialFilter)),
          factoryKey: classFactoryKey,
          state: ProjectsPageBloc(initialFilter: initialFilter),
          createScreen: (b) => ProjectsScreen(bloc: b),
        );

  factory ProjectsPage.fromState(Map<String, dynamic> state) =>
      ProjectsPage(initialFilter: ProjectFilter.fromMap(state));

  static String formatKey({required ProjectFilter filter}) {
    return '${classFactoryKey}_${filter.hash}';
  }
}

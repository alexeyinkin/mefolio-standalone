import 'package:app_state/app_state.dart';
import 'package:flutter/foundation.dart';

import 'bloc.dart';
import 'configurations.dart';
import 'screen.dart';

class ProjectsPage extends BlocMaterialPage<ProjectsPageConfiguration, ProjectsPageBloc> {
  static const factoryKey = 'ProjectsPage';

  ProjectsPage() : super(
    key: const ValueKey(factoryKey),
    factoryKey: factoryKey,
    bloc: ProjectsPageBloc(),
    createScreen: (b) => ProjectsScreen(bloc: b),
  );
}

import 'package:app_state/app_state.dart';
import 'package:flutter/foundation.dart';

import 'bloc.dart';
import 'configurations.dart';
import 'screen.dart';

class ProjectPage
    extends BlocMaterialPage<ProjectPageConfiguration, ProjectPageBloc> {
  static const factoryKey = 'Project';

  ProjectPage({
    required String id,
  }) : super(
          key: ValueKey(formatKey(id: id)),
          factoryKey: factoryKey,
          bloc: ProjectPageBloc(id: id),
          createScreen: (b) => ProjectScreen(bloc: b),
        );

  static String formatKey({required String id}) {
    return '${factoryKey}_$id';
  }
}

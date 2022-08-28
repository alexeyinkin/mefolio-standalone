import 'package:app_state/app_state.dart';
import 'package:flutter/foundation.dart';

import 'bloc.dart';
import 'screen.dart';

class ProjectPage extends StatefulMaterialPage<void, ProjectPageBloc> {
  static const classFactoryKey = 'Project';

  ProjectPage({
    required String id,
  }) : super(
          key: ValueKey(formatKey(id: id)),
          factoryKey: classFactoryKey,
          state: ProjectPageBloc(id: id),
          createScreen: (b) => ProjectScreen(bloc: b),
        );

  factory ProjectPage.fromState(Map<String, dynamic> state) =>
      ProjectPage(id: state['id']);

  static String formatKey({required String id}) {
    return '${classFactoryKey}_$id';
  }
}

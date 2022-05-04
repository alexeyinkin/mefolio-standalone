import 'package:app_state/app_state.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../../widgets/scaffold.dart';
import 'bloc.dart';

class ProjectScreen
    extends StatefulBlocWidget<ProjectPageBloc, ProjectPageBlocState> {
  const ProjectScreen({required ProjectPageBloc bloc}) : super(bloc: bloc);

  @override
  Widget buildWithState(BuildContext context, ProjectPageBlocState? state) {
    final project = state?.project;
    if (project == null) return Container();

    return MyScaffold(
      body: Text(
        project.title,
        style: AppStyle.itemHeader,
      ),
    );
  }
}

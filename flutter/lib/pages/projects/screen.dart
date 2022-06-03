import 'package:app_state/app_state.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../../widgets/my_padding.dart';
import '../../widgets/project_filter_line.dart';
import '../../widgets/project_grid.dart';
import '../../widgets/scaffold.dart';
import 'bloc.dart';

class ProjectsScreen
    extends StatefulBlocWidget<ProjectsPageBloc, ProjectsPageBlocState> {
  ProjectsScreen({
    required super.bloc,
  });

  @override
  Widget buildWithState(BuildContext context, ProjectsPageBlocState? state) {
    if (state == null) return Container();

    return MyScaffold(
      body: Column(
        children: [
          MyPadding(
            child: ProjectFilterLineWidget(projectFilterBloc: bloc.filterBloc),
          ),
          const HorizontalBlackLine(),
          Expanded(
            child: ProjectGridWidget(filter: state.filterBlocState.filter),
          ),
        ],
      ),
    );
  }
}

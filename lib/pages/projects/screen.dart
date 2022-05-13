import 'package:flutter/material.dart';

import '../../widgets/project_list.dart';
import '../../widgets/scaffold.dart';
import 'bloc.dart';

class ProjectsScreen extends StatelessWidget {
  final ProjectsPageBloc bloc;

  const ProjectsScreen({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: ProjectListWidget(filter: bloc.filter),
    );
  }
}

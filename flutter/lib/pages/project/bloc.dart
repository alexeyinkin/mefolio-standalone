import 'package:app_state/app_state.dart';
import 'package:get_it/get_it.dart';
import 'package:model_fetch/model_fetch.dart';

import '../../models/project.dart';
import '../../repositories/project.dart';
import 'configurations.dart';

class ProjectPageBloc
    extends PageStatefulBloc<ProjectPageConfiguration, ProjectPageBlocState> {
  final ModelByIdBloc<String, Project> modelByIdBloc;
  final String id;

  Project? _project;

  ProjectPageBloc({
    required this.id,
  }) : modelByIdBloc = GetIt.instance.get<ProjectRepository>().liveById(id) {
    modelByIdBloc.states.listen(_onProjectChanged);
  }

  void _onProjectChanged(ModelByIdState<String, Project> state) {
    _project = state.model;
    emitState();
  }

  @override
  ProjectPageBlocState createState() {
    return ProjectPageBlocState(project: _project);
  }

  @override
  ProjectPageConfiguration getConfiguration() {
    return ProjectPageConfiguration(id: id);
  }
}

class ProjectPageBlocState {
  final Project? project;

  ProjectPageBlocState({
    required this.project,
  });
}

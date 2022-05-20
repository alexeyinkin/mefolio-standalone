import 'package:app_state/app_state.dart';

import '../../blocs/project_filter.dart';
import '../../filters/project.dart';
import 'configurations.dart';

class ProjectsPageBloc
    extends PageStatefulBloc<ProjectsPageConfiguration, ProjectsPageBlocState> {
  final ProjectFilterBloc filterBloc;

  ProjectFilterBlocState? _filterBlocState;

  ProjectsPageBloc({
    required ProjectFilter initialFilter,
  }) : filterBloc = ProjectFilterBloc(
          initialFilter: initialFilter,
        ) {
    emitState();
    // TODO: Listen to filterBloc
  }

  @override
  ProjectsPageConfiguration getConfiguration() {
    return ProjectsPageConfiguration(
      filter: _filterBlocState?.filter ?? const ProjectFilter(),
    );
  }

  @override
  createState() {
    return ProjectsPageBlocState(
      filterBlocState: _filterBlocState ?? filterBloc.state,
    );
  }

  @override
  void dispose() {
    filterBloc.dispose();
    super.dispose();
  }
}

class ProjectsPageBlocState {
  final ProjectFilterBlocState filterBlocState;

  ProjectsPageBlocState({
    required this.filterBlocState,
  });
}

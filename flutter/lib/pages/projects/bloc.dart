import 'package:app_state/app_state.dart';

import '../../blocs/project_filter.dart';
import '../../filters/project.dart';
import 'path.dart';

class ProjectsPageBloc extends PageStatefulBloc<ProjectsPageBlocState, void> {
  final ProjectFilterBloc filterBloc;

  ProjectFilterBlocState? _filterBlocState;

  ProjectsPageBloc({
    required ProjectFilter initialFilter,
  }) : filterBloc = ProjectFilterBloc(
          initialFilter: initialFilter,
        ) {
    emitState();
    filterBloc.states.listen(_onFilterChange);
  }

  void _onFilterChange(ProjectFilterBlocState state) {
    _filterBlocState = state;
    emitState();
    emitPathChanged();
  }

  @override
  ProjectsPath get path => ProjectsPath(
        filter: _filterBlocState?.filter ?? const ProjectFilter(),
      );

  @override
  ProjectsPageBlocState createState() {
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

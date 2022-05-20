import 'package:rxdart/rxdart.dart';

import '../filters/project.dart';

class ProjectFilterBloc {
  final _statesController = BehaviorSubject<ProjectFilterBlocState>();

  Stream<ProjectFilterBlocState> get states => _statesController.stream;
  ProjectFilterBlocState get state => _createState();

  ProjectFilter _filter;

  ProjectFilterBloc({
    required ProjectFilter initialFilter,
  }) : _filter = initialFilter;

  void setFilter(ProjectFilter filter) {
    if (filter.hash == _filter.hash) return;
    _filter = filter;
  }

  void emitState() {
    _statesController.add(_createState());
  }

  ProjectFilterBlocState _createState() {
    return ProjectFilterBlocState(
      filter: _filter,
    );
  }

  void dispose() {
    _statesController.close();
  }
}

class ProjectFilterBlocState {
  final ProjectFilter filter;

  ProjectFilterBlocState({
    required this.filter,
  });
}

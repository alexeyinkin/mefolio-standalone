import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:model_fetch/model_fetch.dart';
import 'package:model_fetch_firestore/model_fetch_firestore.dart';
import 'package:rxdart/rxdart.dart';

import '../filters/project.dart';
import '../models/project_filter_stat.dart';
import '../repositories/project_filter_stat.dart';

class ProjectFilterBloc {
  final _statesController = BehaviorSubject<ProjectFilterBlocState>();

  Stream<ProjectFilterBlocState> get states => _statesController.stream;
  ProjectFilterBlocState get state => _createState();

  ProjectFilter _filter;

  FirestoreLiveByIdBloc<ProjectFilterStat>? _statBloc;
  StreamSubscription? _statBlocSubscription;
  ModelByIdState<String, ProjectFilterStat> _statState = ModelByIdState<String, ProjectFilterStat>(model: null, status: LoadStatus.notTried);

  ProjectFilterBloc({
    required ProjectFilter initialFilter,
  }) : _filter = initialFilter {
    _updateStatBloc();
  }

  void _updateStatBloc() {
    _statBlocSubscription?.cancel();
    _statBloc = GetIt.instance.get<ProjectFilterStatRepository>().liveById(_filter.id);
    _statBlocSubscription = _statBloc?.states.listen(_onStatChange);
  }

  void _onStatChange(ModelByIdState<String, ProjectFilterStat> state) {
    _statState = state;
    emitState();
  }

  void removeTagAnd(String tag) {
    setFilter(_filter.removeTagAnd(tag));
  }

  void andTag(String tag) {
    setFilter(_filter.andTag(tag));
  }

  void setFilter(ProjectFilter filter) {
    if (filter.hash == _filter.hash) return;

    _filter = filter;
    _updateStatBloc();
  }

  void emitState() {
    _statesController.add(_createState());
  }

  ProjectFilterBlocState _createState() {
    return ProjectFilterBlocState(
      filter: _filter,
      statState: _statState,
    );
  }

  void dispose() {
    _statesController.close();
  }
}

class ProjectFilterBlocState {
  final ProjectFilter filter;
  final ModelByIdState<String, ProjectFilterStat> statState;

  ProjectFilterBlocState({
    required this.filter,
    required this.statState,
  });
}

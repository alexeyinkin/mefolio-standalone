import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:model_fetch/model_fetch.dart';
import 'package:model_fetch_flutter/model_fetch_flutter.dart';

import '../filters/project.dart';
import '../models/project.dart';
import '../repositories/project.dart';
import 'project_grid_card.dart';

class ProjectGridWidget extends StatelessWidget {
  final ProjectFilter filter;

  ProjectGridWidget({
    required this.filter,
  }) : super(key: ValueKey(filter.hash));

  @override
  Widget build(BuildContext context) {
    final bloc = GetIt.instance
        .get<ProjectRepository>()
        .frozenListBloc(filter);

    return CollectionBlocBuilder<Project>(
      bloc: bloc,
      builder: (context, state) => _buildWithState(bloc, state),
    );
  }

  Widget _buildWithState(LazyLoadBloc bloc, CollectionState<Project> state) {
    if (state.items.isEmpty) {
      // TODO: Show "Nothing found. Expand your search".
      return _getTrailing(bloc);
    }

    return LayoutBuilder(
      builder: (context, constraints) => _buildWithStateAndConstraints(bloc, state, constraints),
    );
  }

  Widget _buildWithStateAndConstraints(LazyLoadBloc bloc, CollectionState<Project> state, BoxConstraints constraints) {
    final crossAxisCount = max(constraints.maxWidth ~/ 300, 1);
    final count = state.hasMore ? state.items.length + 1 : state.items.length;

    return GridView.builder(
      itemCount: count,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
      ),
      itemBuilder: (context, i) {
        if (i == state.items.length) {
          // TODO: Show "No more" in the end.
          return _getTrailing(bloc);
        }

        return ProjectGridCard(project: state.items[i]);
      },
    );
  }

  Widget _getTrailing(LazyLoadBloc bloc) {
    return LoadMoreWidget(
      bloc: bloc,
      child: LazyLoadTrailingWidget(
        bloc: bloc,
        // TODO: Scaled CircularProgressIndicator
        loadingBuilder: (context, state) => const Text("Loading..."),
      ),
    );
  }
}

// TODO: Combine with LoadMoreWidget?
// TODO: Extract to model_fetch_flutter
class LazyLoadTrailingWidget extends StatelessWidget {
  final LazyLoadBloc bloc;
  final Widget Function(BuildContext context, CollectionState state)?
      loadingBuilder;
  final Widget Function(BuildContext context, CollectionState state)?
      noMoreBuilder;
  final Widget Function(BuildContext context, CollectionState state)?
      errorBuilder;

  const LazyLoadTrailingWidget({
    super.key,
    required this.bloc,
    this.loadingBuilder,
    this.noMoreBuilder,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return CollectionBlocBuilder(
      bloc: bloc,
      builder: _buildWithState,
    );
  }

  Widget _buildWithState(BuildContext context, CollectionState state) {
    switch (state.status) {
      case LoadStatus.error:
        return (errorBuilder ?? _defaultBuilder)(context, state);

      case LoadStatus.notTried:
      case LoadStatus.loading:
        return (loadingBuilder ?? _defaultBuilder)(context, state);

      case LoadStatus.ok:
        return state.hasMore
            ? (loadingBuilder ?? _defaultBuilder)(context, state)
            : (noMoreBuilder ?? _defaultBuilder)(context, state);
    }
  }

  Widget _defaultBuilder(BuildContext context, CollectionState state) {
    return Container();
  }
}

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:model_fetch/model_fetch.dart';
import 'package:model_fetch_flutter/model_fetch_flutter.dart';

import '../filters/project.dart';
import '../models/project.dart';
import '../repositories/project.dart';
import '../theme/theme.dart';
import 'project_card.dart';

class ProjectListWidget extends StatelessWidget {
  const ProjectListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = GetIt.instance
        .get<ProjectRepository>()
        .frozenListBloc(const ProjectFilter());

    return LazyLoadBuilder<Project>(
      bloc: bloc,
      builder: (context, state) => _buildWithState(bloc, state),
    );
  }

  Widget _buildWithState(LazyLoadBloc bloc, LazyLoadState<Project> state) {
    if (state.items.isEmpty) {
      // TODO: Show "Nothing found. Expand your search".
      return _getTrailing(bloc);
    }

    final lastIndex = state.items.length * 2;

    return ListView.builder(
      itemCount: state.items.length * 2 + 1,
      itemBuilder: (context, i) {
        if (i.isOdd) return HorizontalLineSeparator();

        if (i == lastIndex) {
          // TODO: Show "No more" in the end.
          return _getTrailing(bloc);
        }

        return ProjectCard(project: state.items[i ~/ 2]);
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
  final Widget Function(BuildContext context, LazyLoadState state)?
      loadingBuilder;
  final Widget Function(BuildContext context, LazyLoadState state)?
      noMoreBuilder;
  final Widget Function(BuildContext context, LazyLoadState state)?
      errorBuilder;

  const LazyLoadTrailingWidget({
    Key? key,
    required this.bloc,
    this.loadingBuilder,
    this.noMoreBuilder,
    this.errorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LazyLoadBuilder(
      bloc: bloc,
      builder: _buildWithState,
    );
  }

  Widget _buildWithState(BuildContext context, LazyLoadState state) {
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

  Widget _defaultBuilder(BuildContext context, LazyLoadState state) {
    return Container();
  }
}

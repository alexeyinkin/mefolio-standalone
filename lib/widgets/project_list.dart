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
      builder: (context, state) => _buildWithList(bloc, state),
    );
  }

  Widget _buildWithList(LazyLoadBloc bloc, LazyLoadState<Project> state) {
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
    return LoadMoreWidget(bloc: bloc, child: const Text('Loading...'));
  }
}

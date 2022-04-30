import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:model_fetch/model_fetch.dart';
import 'package:model_fetch_flutter/model_fetch_flutter.dart';

import '../filters/project.dart';
import '../models/project.dart';
import '../repositories/project.dart';

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
    return ListView.builder(
      itemCount: state.items.length + 1,
      itemBuilder: (context, i) {
        if (i == state.items.length) {
          return LoadMoreWidget(bloc: bloc, child: const Text('Loading...'));
        }

        return Text(state.items[i].title);
      },
    );
  }
}

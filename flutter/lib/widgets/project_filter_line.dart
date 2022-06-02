import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:model_fetch/model_fetch.dart';

import '../blocs/project_filter.dart';
import '../blocs/tag_dictionary.dart';
import '../theme/theme.dart';
import '../util/util.dart';
import 'tag.dart';

class ProjectFilterLineWidget extends StatelessWidget {
  final ProjectFilterBloc projectFilterBloc;

  ProjectFilterLineWidget({
    required this.projectFilterBloc,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProjectFilterBlocState>(
      stream: projectFilterBloc.states,
      builder: (context, snapshot) =>
          _buildWithState(snapshot.data ?? projectFilterBloc.state),
    );
  }

  Widget _buildWithState(ProjectFilterBlocState state) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _getStatusWidget(state),
                const MySpacing(),
                ..._getActiveWidgets(state),
                const MySpacing(),
                ..._getAddableTagWidgets(state),
              ],
            ),
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          icon: Icon(Icons.filter_alt),
          onPressed: _onFilterPressed,
        ),
      ],
    );
  }

  Widget _getStatusWidget(ProjectFilterBlocState state) {
    final statState = state.statState;
    switch (statState.status) {
      case LoadStatus.error:
        return const Text("None Found");

      case LoadStatus.loading:
        return const Text("Loading...");

      default:
        final count = statState.model?.count;
        return Text("Showing $count");
    }
  }

  List<Widget> _getActiveWidgets(ProjectFilterBlocState state) {
    final filter = state.filter;
    final result = <Widget>[];

    for (final tag in filter.tagsAnd ?? []) {
      result.add(
        FilterTagWidget(
          child: Text(tag),
          onRemovePressed: () {
            projectFilterBloc.removeTagAnd(tag);
          },
        ),
      );
    }

    return result.alternateWith(const MySpacing());
  }

  List<Widget> _getAddableTagWidgets(ProjectFilterBlocState state) {
    final bloc = GetIt.instance.get<TagDictionaryBloc>();
    final tags = bloc.createState().items;

    return tags.map<Widget>((obj) => TagWidget(
      tag: obj.title,
      onPressed: () => projectFilterBloc.andTag(obj.title),
    )).toList(growable: false);
  }

  void _onFilterPressed() {}
}

class FilterTagWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onRemovePressed;

  FilterTagWidget({
    required this.child,
    required this.onRemovePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppStyle.activeTagColor,
        borderRadius: BorderRadius.circular(100),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: [
          child,
          // TODO: Make NoPaddingIconButton
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: onRemovePressed,
            icon: const Icon(Icons.cancel),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../blocs/project_filter.dart';
import '../theme/theme.dart';

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
                ..._getActiveWidgets(state),
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
    if (state.filter.isEmpty) {
      return Text("Showing All.");
    }

    return Text("Showing");
  }

  List<Widget> _getActiveWidgets(ProjectFilterBlocState state) {
    final filter = state.filter;
    final result = <Widget>[];

    for (final tag in filter.tagsAnd ?? []) {
      result.add(
        FilterTagWidget(
          child: Text(tag),
        ),
      );
    }

    return result;
  }

  void _onFilterPressed() {}
}

class FilterTagWidget extends StatelessWidget {
  final Widget child;

  FilterTagWidget({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppStyle.activeTagColor,
        borderRadius: BorderRadius.circular(100),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: child,
    );
  }
}

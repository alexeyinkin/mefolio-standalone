import 'package:flutter/material.dart';

import '../filters/project.dart';
import '../main.dart';
import '../pages/projects/page.dart';
import '../theme/theme.dart';
import '../widgets/clickable.dart';

class TagWidget extends StatelessWidget {
  final String tag;

  const TagWidget({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClickableWidget(
      onTap: _onTap,
      child: Text(
        tag,
        style: AppStyle.tag,
      ),
    );
  }

  void _onTap() {
    pageStacksBloc.currentStackBloc?.push(
      ProjectsPage(
        filter: ProjectFilter(tagsAnd: [tag]),
      ),
    );
  }
}

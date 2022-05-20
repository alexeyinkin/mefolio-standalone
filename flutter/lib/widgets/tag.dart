import 'package:flutter/material.dart';

import '../filters/project.dart';
import '../main.dart';
import '../pages/projects/page.dart';
import '../theme/theme.dart';

class TagWidget extends StatelessWidget {
  final String tag;

  const TagWidget({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        minimumSize: const Size(20, 40),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft,
      ),
      onPressed: _onTap,
      child: Text(
        tag,
        style: AppStyle.tag,
      ),
    );
  }

  void _onTap() {
    pageStacksBloc.currentStackBloc?.push(
      ProjectsPage(
        initialFilter: ProjectFilter(tagsAnd: [tag]),
      ),
    );
  }
}

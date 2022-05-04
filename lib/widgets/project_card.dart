import 'package:flutter/material.dart';

import '../main.dart';
import '../models/project.dart';
import '../pages/project/page.dart';
import '../theme/theme.dart';
import 'clickable.dart';
import 'tags.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  static const twoColumnMinWidth = 600;

  const ProjectCard({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClickableWidget(
      onTap: _onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: LayoutBuilder(builder: _buildWithLayout),
      ),
    );
  }

  Widget _buildWithLayout(BuildContext context, BoxConstraints constraints) {
    print(constraints);
    if (constraints.maxWidth < twoColumnMinWidth) {
      return _buildOneColumn(context);
    }

    return _buildTwoColumns(context);
  }

  Widget _buildOneColumn(BuildContext context) {
    return Column(
      children: [
        // TODO: Contain in (width x 300). If shorter, go shorter.
        SizedBox(
          height: 300,
          child: Image.network(project.imageUrl, fit: BoxFit.contain),
        ),
        const MySpacing(),
        _getTitleWidget(context),
        const MySpacing(),
        _getDescriptionWidget(context),
        const MySpacing(),
        _getTagsWidget(),
      ],
    );
  }

  Widget _buildTwoColumns(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 300,
              height: 150,
              child: Image.network(project.imageUrl),
            ),
            const MySpacing(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getTitleWidget(context),
                  const MySpacing(),
                  _getDescriptionWidget(context),
                ],
              ),
            ),
          ],
        ),
        const MySpacing(),
        _getTagsWidget(),
      ],
    );
  }

  Widget _getTitleWidget(BuildContext context) {
    return Text(
      project.title,
      style: AppStyle.itemHeader,
    );
  }

  Widget _getDescriptionWidget(BuildContext context) {
    return Text(
      project.description,
    );
  }

  Widget _getTagsWidget() {
    return Container(
      alignment: Alignment.centerRight,
      child: TagsWidget(tags: project.tags),
    );
  }

  void _onTap() {
    pageStacksBloc.currentStackBloc?.push(ProjectPage(id: project.id));
  }
}

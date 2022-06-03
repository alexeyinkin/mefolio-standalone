import 'package:flutter/material.dart';

import '../main.dart';
import '../models/project.dart';
import '../pages/project/page.dart';
import '../theme/theme.dart';
import 'clickable.dart';

class ProjectGridCard extends StatelessWidget {
  final Project project;

  const ProjectGridCard({
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return ClickableWidget(
      onTap: _onTap,
      child: Stack(
        children: [
          _background(),
          _image(),
          _text(),
        ],
      ),
    );
  }

  Widget _background() {
    return Positioned.fill(
      child: Container(
        color: Color(project.view.backgroundColor),
      ),
    );
  }

  Widget _image() {
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: Image.network(project.imageUrl, fit: BoxFit.contain),
    );
  }

  Widget _text() {
    return DefaultTextStyle(
      style: TextStyle(color: Color(project.view.textColor)),
      child: Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
          color: Color(project.view.textBackgroundColor),
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.title,
                style: AppStyle.itemHeader,
              ),
              const MySpacing(),
              Text(
                project.description,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap() {
    pageStacksBloc.currentStackBloc?.push(ProjectPage(id: project.id));
  }
}

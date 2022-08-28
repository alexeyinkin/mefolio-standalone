import 'package:app_state/app_state.dart';
import 'package:flutter/widgets.dart';

import '../../filters/project.dart';
import '../../router/tab_enum.dart';
import '../projects/path.dart';
import 'page.dart';

class ProjectPath extends PagePath {
  final String id;

  static final _regExp = RegExp(r'^/projects/([-a-zA-Z0-9.]+)$');

  ProjectPath({
    required this.id,
  }) : super(
          key: ProjectPage.formatKey(id: id),
          factoryKey: ProjectPage.classFactoryKey,
          state: {'id': id},
        );

  @override
  String get location => '/projects/$id';

  static ProjectPath? tryParse(RouteInformation ri) {
    final matches = _regExp.firstMatch(ri.location ?? '');
    if (matches == null) return null;

    final id = matches[1];

    if (id == null) {
      return null; // Will never get here with present _regExp.
    }

    return ProjectPath(
      id: id,
    );
  }

  @override
  List<PagePath> get defaultStackPaths => [
        ProjectsPath(filter: const ProjectFilter()),
        this,
      ];

  @override
  String get defaultStackKey => TabEnum.projects.name;
}

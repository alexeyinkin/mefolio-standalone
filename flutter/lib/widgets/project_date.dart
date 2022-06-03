import 'package:charcode/html_entity.dart';
import 'package:flutter/widgets.dart';

import '../models/project.dart';
import '../util/util.dart';

class ProjectDateWidget extends StatelessWidget {
  final Project project;

  const ProjectDateWidget({
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    final parts = <String>[];

    if (project.dateTimeRelease != null) {
      parts.add("Released " + formatDate(project.dateTimeRelease!));
    }

    if (project.dateTimeStart != null) {
      parts.add("Started " + formatDate(project.dateTimeStart!));
    }

    if (project.dateTimeEnd != null) {
      parts.add("Ended " + formatDate(project.dateTimeEnd!));
    }

    return Text(parts.join(' ' + String.fromCharCode($mdash) + ' '));
  }
}

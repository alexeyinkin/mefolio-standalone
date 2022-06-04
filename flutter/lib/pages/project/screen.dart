import 'package:app_state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/theme.dart';
import '../../widgets/my_padding.dart';
import '../../widgets/project_date.dart';
import '../../widgets/scaffold.dart';
import '../../widgets/tags.dart';
import '../../widgets/urls.dart';
import 'bloc.dart';

class ProjectScreen
    extends StatefulBlocWidget<ProjectPageBloc, ProjectPageBlocState> {
  const ProjectScreen({required ProjectPageBloc bloc}) : super(bloc: bloc);

  @override
  Widget buildWithState(BuildContext context, ProjectPageBlocState? state) {
    final project = state?.project;
    if (project == null) return Container();

    return MyScaffold(
      body: MyPadding(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                project.title,
                style: AppStyle.itemHeader,
              ),
              const MySpacing(),
              UrlsWidget(urls: project.urls),
              Markdown(
                data: project.body,
                shrinkWrap: true,
                onTapLink: (text, url, title) {
                  if (url == null) return;
                  launchUrl(Uri.parse(url));
                },
                styleSheet: MarkdownStyleSheet(
                  a: const TextStyle(color: AppStyle.primaryColor),
                ),
              ),
              const MySpacing(),
              NewPageTagsWidget(tags: project.tags),
              HorizontalLineSeparator(),
              const MySpacing(),
              ProjectDateWidget(project: project),
            ],
          ),
        ),
      ),
    );
  }
}

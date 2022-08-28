import 'package:app_state/app_state.dart';

import '../pages/contact/page.dart';
import '../pages/project/page.dart';
import '../pages/projects/page.dart';

class PageFactory {
  static AbstractPage? createPage(
    String factoryKey,
    Map<String, dynamic> state,
  ) {
    switch (factoryKey) {
      case ContactPage.classFactoryKey:
        return ContactPage.fromState(state);

      case ProjectPage.classFactoryKey:
        return ProjectPage.fromState(state);

      case ProjectsPage.classFactoryKey:
        return ProjectsPage.fromState(state);
    }

    return null;
  }
}

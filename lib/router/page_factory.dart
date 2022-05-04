import 'package:app_state/app_state.dart';

import '../pages/contact/page.dart';
import '../pages/project/page.dart';
import '../pages/projects/page.dart';

class PageFactory {
  static AbstractPage<PageConfiguration>? createPage(
    String factoryKey,
    Map<String, dynamic> state,
  ) {
    switch (factoryKey) {
      case ContactPage.factoryKey: return ContactPage();
      case ProjectPage.factoryKey: return ProjectPage(id: state['id']);
      case ProjectsPage.factoryKey: return ProjectsPage();
    }

    return null;
  }
}

import 'package:app_state/app_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

import 'filters/project.dart';
import 'firebase_options.dart'; // Generated with CLI installation, https://firebase.google.com/docs/flutter/setup
import 'locator.dart';
import 'pages/contact/page.dart';
import 'pages/home/screen.dart';
import 'pages/projects/page.dart';
import 'router/page_factory.dart';
import 'router/route_information_parser.dart';
import 'router/tab_enum.dart';
import 'theme/theme.dart';

final pageStacks = PageStacks();

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeServiceLocator();

  pageStacks.addPageStack(
    TabEnum.projects.name,
    PageStack(
      bottomPage: ProjectsPage(initialFilter: const ProjectFilter()),
      createPage: PageFactory.createPage,
    ),
  );

  pageStacks.addPageStack(
    TabEnum.contact.name,
    PageStack(
      bottomPage: ContactPage(),
      createPage: PageFactory.createPage,
    ),
  );

  pageStacks.setCurrentStackKey(TabEnum.projects.name, fire: false);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _routerDelegate = MaterialPageStacksRouterDelegate(
    pageStacks,
    child: HomeScreen(pageStacks: pageStacks),
  );
  final _routeInformationParser = MyRouteInformationParser();
  final _backButtonDispatcher = PageStacksBackButtonDispatcher(pageStacks);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
      backButtonDispatcher: _backButtonDispatcher,
      theme: themeData,
    );
  }
}

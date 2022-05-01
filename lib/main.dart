import 'package:app_state/app_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

import 'firebase_options.dart'; // Generated with CLI installation, https://firebase.flutter.dev/docs/cli
import 'locator.dart';
import 'pages/contact/page.dart';
import 'pages/home/screen.dart';
import 'pages/projects/page.dart';
import 'router/page_factory.dart';
import 'router/route_information_parser.dart';
import 'router/tab_enum.dart';
import 'theme/theme.dart';

final pageStacksBloc = PageStacksBloc();

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeServiceLocator();

  pageStacksBloc.addPageStack(
    TabEnum.projects.name,
    PageStackBloc<PageConfiguration>(
      bottomPage: ProjectsPage(),
      createPage: PageFactory.createPage,
    ),
  );

  pageStacksBloc.addPageStack(
    TabEnum.contact.name,
    PageStackBloc<PageConfiguration>(
      bottomPage: ContactPage(),
      createPage: PageFactory.createPage,
    ),
  );

  pageStacksBloc.setCurrentStackKey(TabEnum.projects.name, fire: false);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _routerDelegate = MaterialPageStacksRouterDelegate(
    pageStacksBloc: pageStacksBloc,
    child: HomeScreen(pageStacksBloc: pageStacksBloc),
  );
  final _routeInformationParser = MyRouteInformationParser();
  final _backButtonDispatcher = PageStacksBackButtonDispatcher(pageStacksBloc);

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

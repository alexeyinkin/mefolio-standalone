import 'package:get_it/get_it.dart';

import 'repositories/project.dart';

Future<void> initializeServiceLocator() async {
  _initializeRepositories();
}

void _initializeRepositories() {
  GetIt.instance
    ..registerSingleton<ProjectRepository>(ProjectRepository())
  ;
}

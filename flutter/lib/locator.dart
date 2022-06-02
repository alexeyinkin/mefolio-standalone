import 'package:get_it/get_it.dart';

import 'blocs/tag_dictionary.dart';
import 'repositories/project.dart';
import 'repositories/project_filter_stat.dart';

Future<void> initializeServiceLocator() async {
  _initializeRepositories();
  _initializeDictionaries();
}

void _initializeRepositories() {
  GetIt.instance
    ..registerSingleton<ProjectRepository>(ProjectRepository())
    ..registerSingleton<ProjectFilterStatRepository>(ProjectFilterStatRepository())
  ;
}

void _initializeDictionaries() {
  GetIt.instance
    ..registerSingleton<TagDictionaryBloc>(TagDictionaryBloc())
  ;
}

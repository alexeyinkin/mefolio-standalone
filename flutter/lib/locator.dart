// ignore_for_file: lines_longer_than_80_chars

import 'package:get_it/get_it.dart';

import 'blocs/global.dart';
import 'blocs/role_dictionary.dart';
import 'blocs/tag_dictionary.dart';
import 'repositories/global.dart';
import 'repositories/project.dart';
import 'repositories/project_filter_stat.dart';

Future<void> initializeServiceLocator() async {
  _initializeRepositories();
  _initializeDictionaries();
}

void _initializeRepositories() {
  GetIt.instance
    ..registerSingleton<GlobalRepository>(GlobalRepository())
    ..registerSingleton<ProjectRepository>(ProjectRepository())
    ..registerSingleton<ProjectFilterStatRepository>(ProjectFilterStatRepository())
  ;
}

void _initializeDictionaries() {
  GetIt.instance
    ..registerSingleton<GlobalBloc>(GlobalBloc())
    ..registerSingleton<RoleDictionaryBloc>(RoleDictionaryBloc())
    ..registerSingleton<TagDictionaryBloc>(TagDictionaryBloc())
  ;
}

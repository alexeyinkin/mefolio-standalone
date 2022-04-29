import 'package:app_state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:keyed_collection_widgets/keyed_collection_widgets.dart';

import '../../router/tab_enum.dart';

class HomeScreen extends StatelessWidget {
  final PageStacksBloc pageStacksBloc;

  HomeScreen({
    required this.pageStacksBloc,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: pageStacksBloc.events,
      builder: (context, snapshot) => _buildOnEvent(),
    );
  }

  Widget _buildOnEvent() {
    final tab = TabEnum.values.byName(pageStacksBloc.currentStackKey!);

    return Scaffold(
      body: KeyedStack<TabEnum>(
        itemKey: tab,
        children: pageStacksBloc.pageStacks.map((tabString, bloc) => MapEntry(
          TabEnum.values.byName(tabString),
          PageStackBlocNavigator(key: ValueKey(tabString), bloc: bloc)),
        ),
      ),
      bottomNavigationBar: KeyedBottomNavigationBar<TabEnum>(
        currentItemKey: tab,
        items: const {
          TabEnum.projects: BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Projects',
          ),
          TabEnum.contact: BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Contact',
          ),
        },
        onTap: (tab) => pageStacksBloc.setCurrentStackKey(tab.name),
      ),
    );
  }
}

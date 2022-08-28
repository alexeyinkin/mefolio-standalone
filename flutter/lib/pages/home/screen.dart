import 'package:app_state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:keyed_collection_widgets/keyed_collection_widgets.dart';

import '../../router/tab_enum.dart';

class HomeScreen extends StatelessWidget {
  final PageStacks pageStacks;

  const HomeScreen({
    required this.pageStacks,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: pageStacks.events,
      builder: (context, snapshot) => _buildOnEvent(),
    );
  }

  Widget _buildOnEvent() {
    final tab = TabEnum.values.byName(pageStacks.currentStackKey!);

    return Scaffold(
      body: KeyedStack<TabEnum>(
        itemKey: tab,
        children: pageStacks.pageStacks.map(
          (tabString, stack) => MapEntry(
            TabEnum.values.byName(tabString),
            PageStackNavigator(key: ValueKey(tabString), stack: stack),
          ),
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
        onTap: _onTabTap,
      ),
    );
  }

  void _onTabTap(TabEnum tab) {
    final key = tab.name;

    if (pageStacks.currentStackKey == key) {
      pageStacks.currentStack?.popUntilBottom();
    } else {
      pageStacks.setCurrentStackKey(key);
    }
  }
}

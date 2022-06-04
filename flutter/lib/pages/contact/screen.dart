import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:model_fetch/model_fetch.dart';

import '../../blocs/global.dart';
import '../../models/global.dart';
import '../../widgets/my_padding.dart';
import '../../widgets/scaffold.dart';
import 'widgets/contacts.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: MyPadding(
        child: StreamBuilder<ModelByIdState<String, Global>>(
          stream: GetIt.instance.get<GlobalBloc>().states,
          builder: (context, snapshot) => _buildWithState(snapshot.data?.model),
        ),
      ),
    );
  }

  Widget _buildWithState(Global? global) {
    if (global == null) return Text("...");

    return LayoutBuilder(builder: (context, constraints) {
      return constraints.maxHeight > constraints.maxWidth
          ? _buildVertical(global)
          : _buildHorizontal(global);
    });
  }

  Widget _buildVertical(Global global) {
    return Column(
      children: [
        Expanded(
          child: Image.network(global.imageUrl),
        ),
        const SizedBox(height: 30),
        Expanded(
          child: ContactsWidget(contacts: global.contacts),
        ),
      ],
    );
  }

  Widget _buildHorizontal(Global global) {
    return Row(
      children: [
        Expanded(
          child: Image.network(global.imageUrl),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: ContactsWidget(contacts: global.contacts),
        ),
      ],
    );
  }
}

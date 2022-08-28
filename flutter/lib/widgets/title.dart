import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:model_fetch/model_fetch.dart';

import '../blocs/global.dart';
import '../models/global.dart';
import '../theme/theme.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ModelByIdState<String, Global>>(
      stream: GetIt.instance.get<GlobalBloc>().states,
      builder: (context, snapshot) => _buildWithState(snapshot.data?.model),
    );
  }

  Widget _buildWithState(Global? global) {
    if (global == null) return Text('...', style: AppStyle.h1);

    return Text(global.title, style: AppStyle.h1);
  }
}

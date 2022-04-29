import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

class PaddedScrollable extends StatelessWidget {
  final Widget child;

  const PaddedScrollable({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: AppStyle.edgeInsets,
        child: child,
      ),
    );
  }
}

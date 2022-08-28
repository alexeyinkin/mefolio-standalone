import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

class MyPadding extends StatelessWidget {
  final Widget child;

  const MyPadding({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppStyle.edgeInsets,
      child: child,
    );
  }
}

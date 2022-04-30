import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

class MyPadding extends StatelessWidget {
  final Widget child;

  const MyPadding({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppStyle.edgeInsets,
      child: child,
    );
  }
}

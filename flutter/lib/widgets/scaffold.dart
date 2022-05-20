import 'package:flutter/material.dart';

import '../theme/theme.dart';

class MyScaffold extends StatelessWidget {
  final Widget body;

  const MyScaffold({
    required this.body,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "Alexey Inkin",
              style: AppStyle.h1,
            ),
            const HorizontalBlackLine(),
            Expanded(
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}

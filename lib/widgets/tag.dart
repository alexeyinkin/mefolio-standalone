import 'package:flutter/material.dart';

import '../theme/theme.dart';

class TagWidget extends StatelessWidget {
  final String tag;

  const TagWidget({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      tag,
      style: AppStyle.tag,
    );
  }
}

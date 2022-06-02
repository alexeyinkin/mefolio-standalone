import 'package:flutter/material.dart';

import '../theme/theme.dart';

class TagWidget extends StatelessWidget {
  final String tag;
  final VoidCallback onPressed;

  const TagWidget({
    Key? key,
    required this.tag,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        minimumSize: const Size(20, 40),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft,
      ),
      onPressed: onPressed,
      child: Text(
        tag,
        style: AppStyle.tag,
      ),
    );
  }
}

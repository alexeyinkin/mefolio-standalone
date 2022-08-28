import 'package:flutter/material.dart';

import '../theme/theme.dart';

class TagWidget extends StatelessWidget {
  final String tag;
  final int? count;
  final VoidCallback onPressed;

  const TagWidget({
    super.key,
    required this.tag,
    this.count,
    required this.onPressed,
  });

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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(tag, style: AppStyle.tag),
          if (count != null) Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Opacity(
              opacity: .3,
              child: Text('$count', style: AppStyle.normal),
            ),
          ),
        ],
      ),
    );
  }
}

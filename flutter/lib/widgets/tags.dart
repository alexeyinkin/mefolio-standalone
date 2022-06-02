import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'my_padding.dart';
import 'tag.dart';

class TagsWidget extends StatelessWidget {
  final Iterable<String> tags;
  final ValueChanged<String> onPressed;

  const TagsWidget({
    Key? key,
    required this.tags,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return Container();

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        MyPadding(
          child: Transform.rotate(
            angle: math.pi / 2,
            child: const Icon(Icons.discount, size: 16),
          ),
        ),
        ...tags.map((s) => TagWidget(tag: s, onPressed: () => onPressed(s))),
      ],
    );
  }
}

import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'my_padding.dart';
import 'tag.dart';

class TagsWidget extends StatelessWidget {
  final List<String> tags;

  const TagsWidget({
    Key? key,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return Container();

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        MyPadding(
          child: Transform.rotate(
            child: const Icon(Icons.discount, size: 16),
            angle: math.pi / 2,
          ),
        ),
        ...tags.map((s) => TagWidget(tag: s)),
      ],
    );
  }
}

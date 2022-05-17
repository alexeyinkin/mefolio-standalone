import 'package:flutter/material.dart';

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
      spacing: 10,
      children: [
        const Icon(Icons.tag, size: 16),
        ...tags.map((s) => TagWidget(tag: s)),
      ],
    );
  }
}

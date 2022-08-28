import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../filters/project.dart';
import '../main.dart';
import '../pages/projects/page.dart';
import 'my_padding.dart';
import 'tag.dart';

class TagsWidget extends StatelessWidget {
  final Iterable<String> tags;
  final ValueChanged<String> onPressed;

  const TagsWidget({
    super.key,
    required this.tags,
    required this.onPressed,
  });

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

class NewPageTagsWidget extends StatelessWidget {
  final Iterable<String> tags;
  const NewPageTagsWidget({required this.tags,});

  @override
  Widget build(BuildContext context) {
    return TagsWidget(
      tags: tags,
      onPressed: _onTagPressed,
    );
  }

  void _onTagPressed(String tag) {
    pageStacks.currentStack?.push(
      ProjectsPage(
        initialFilter: ProjectFilter(tagsAnd: [tag]),
      ),
    );
  }
}

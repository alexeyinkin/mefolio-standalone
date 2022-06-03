import 'package:flutter/material.dart';

import '../models/external_url.dart';
import 'url.dart';

class UrlsWidget extends StatelessWidget {
  final List<ExternalUrl> urls;

  const UrlsWidget({
    required this.urls,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: urls
          .map(
            (url) => UrlWidget(url: url),
          )
          .toList(growable: false),
    );
  }
}

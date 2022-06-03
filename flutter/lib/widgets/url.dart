import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import '../models/external_url.dart';
import '../theme/theme.dart';

class UrlWidget extends StatelessWidget {
  final ExternalUrl url;

  const UrlWidget({
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Link(
      uri: url.uri,
      builder: (context, followLink) => TextButton(
        style: AppStyle.narrowBorderTextButton,
        onPressed: followLink,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const Icon(Icons.link),
              const MySpacing(),
              Text(url.uri.toString()),
              if (url.title != null) Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(url.title ?? '', style: AppStyle.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

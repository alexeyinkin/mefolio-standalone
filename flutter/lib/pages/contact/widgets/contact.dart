import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import '../../../enum/contact_type.dart';
import '../../../models/contact.dart';
import '../../../theme/theme.dart';
import 'contact_icon.dart';

class ContactWidget extends StatelessWidget {
  final Contact contact;

  const ContactWidget({
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Link(
      uri: _uri,
      builder: (context, followLink) => TextButton(
        style: AppStyle.narrowBorderTextButton,
        onPressed: followLink,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ContactIconWidget(contact: contact),
              const MySpacing(),
              Text(contact.value),
            ],
          ),
        ),
      ),
    );
  }

  Uri get _uri {
    final value = contact.value;

    switch (contact.type) {
      case ContactType.email:
        return Uri.parse('mailto:$value');

      case ContactType.instagram:
        return Uri.parse('https://instagram.com/$value');

      case ContactType.vk:
        return Uri.parse('https://vk.com/$value');
    }

    return Uri.parse(contact.value);
  }
}

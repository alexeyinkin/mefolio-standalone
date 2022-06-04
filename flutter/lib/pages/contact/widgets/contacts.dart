import 'package:flutter/material.dart';

import '../../../models/contact.dart';
import '../../../util/util.dart';
import 'contact.dart';

class ContactsWidget extends StatelessWidget {
  final List<Contact> contacts;

  const ContactsWidget({
    required this.contacts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: contacts
          .map<Widget>(
            (c) => ContactWidget(contact: c),
          )
          .alternateWith(const SizedBox(height: 5))
          .toList(growable: false),
    );
  }
}

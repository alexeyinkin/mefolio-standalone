import 'package:flutter/material.dart';

import '../../../models/contact.dart';
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
          .map(
            (c) => ContactWidget(contact: c),
          )
          .toList(growable: false),
    );
  }
}

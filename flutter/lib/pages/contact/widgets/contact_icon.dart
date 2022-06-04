import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../enum/contact_type.dart';
import '../../../models/contact.dart';

class ContactIconWidget extends StatelessWidget {
  final Contact contact;

  static const size = 36.0;

  const ContactIconWidget({
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    switch (contact.type) {
      case ContactType.email:
        return const Icon(Icons.mail, size: size);

      case ContactType.instagram:
      case ContactType.vk:
        return SvgPicture.asset(
          'assets/contact/${contact.type}.svg',
          width: size,
      );

      default:
        return const Icon(Icons.link, size: size);
    }
  }
}

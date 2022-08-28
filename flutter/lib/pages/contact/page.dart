import 'package:app_state/app_state.dart';
import 'package:flutter/foundation.dart';

import 'path.dart';
import 'screen.dart';

class ContactPage extends StatelessMaterialPage<void> {
  static const classFactoryKey = 'Contact';

  ContactPage() : super(
    key: const ValueKey(classFactoryKey),
    factoryKey: classFactoryKey,
    path: const ContactPath(),
    child: const ContactScreen(),
  );

  factory ContactPage.fromState(Map<String, dynamic> state) => ContactPage();
}

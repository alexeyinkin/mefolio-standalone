import 'package:app_state/app_state.dart';
import 'package:flutter/foundation.dart';

import 'configurations.dart';
import 'screen.dart';

class ContactPage extends StatelessMaterialPage<ContactPageConfiguration> {
  static const factoryKey = 'Contact';

  ContactPage() : super(
    key: const ValueKey(factoryKey),
    factoryKey: factoryKey,
    configuration: const ContactPageConfiguration(),
    child: ContactScreen(),
  );
}

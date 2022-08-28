import 'package:app_state/app_state.dart';
import 'package:flutter/widgets.dart';

import '../../router/tab_enum.dart';
import 'page.dart';

class ContactPath extends PagePath {
  static const _location = '/contact';

  const ContactPath() : super(key: ContactPage.classFactoryKey);

  @override
  String get location => _location;

  static ContactPath? tryParse(RouteInformation ri) {
    final uri = Uri.parse(ri.location ?? '');
    if (uri.path != _location) return null;

    return const ContactPath();
  }

  @override
  String get defaultStackKey => TabEnum.contact.name;
}

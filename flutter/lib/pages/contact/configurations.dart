import 'package:app_state/app_state.dart';
import 'package:flutter/widgets.dart';

import 'page.dart';
import '../../router/tab_enum.dart';

class ContactPageConfiguration extends PageConfiguration {
  static const _location = '/contact';

  const ContactPageConfiguration() : super(key: ContactPage.factoryKey);

  @override
  RouteInformation restoreRouteInformation() {
    return const RouteInformation(location: _location);
  }

  static ContactPageConfiguration? tryParse(RouteInformation ri) {
    final uri = Uri.parse(ri.location ?? '');
    if (uri.path != _location) return null;

    return const ContactPageConfiguration();
  }

  @override
  String get defaultStackKey => TabEnum.contact.name;
}

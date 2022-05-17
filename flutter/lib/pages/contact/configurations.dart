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

  @override
  String get defaultStackKey => TabEnum.contact.name;
}

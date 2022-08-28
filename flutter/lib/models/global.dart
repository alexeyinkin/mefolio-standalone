import 'package:model_interfaces/model_interfaces.dart';

import 'contact.dart';
import 'versions.dart';

class Global implements WithId<String> {
  @override
  String get id => singleId;
  final List<Contact> contacts;
  final String imageUrl;
  final String title;
  final Versions versions;

  const Global({
    required this.contacts,
    required this.imageUrl,
    required this.title,
    required this.versions,
  });

  static const singleId = 'Global';

  factory Global.fromMap(Map<String, dynamic> map) {
    return Global(
      contacts: Contact.fromMaps(map['contacts']),
      imageUrl: map['imageUrl'],
      title: map['title'],
      versions: Versions.fromMap(map['versions']),
    );
  }
}

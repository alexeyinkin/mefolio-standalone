class Contact {
  final String type;
  final String value;

  const Contact({
    required this.type,
    required this.value,
  });

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      type: map['type'],
      value: map['value'],
    );
  }

  static List<Contact> fromMaps(List maps) {
    return maps
        .cast<Map<String, dynamic>>()
        .map((map) => Contact.fromMap(map))
        .toList(growable: false);
  }
}

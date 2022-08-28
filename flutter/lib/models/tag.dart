import 'package:model_interfaces/model_interfaces.dart';

class Tag extends WithIdTitle<String> {
  Tag(super.id, super.title);

  factory Tag.fromIdAndMap(String id, Map<String, dynamic> map) {
    return Tag(id, map['title'] ?? id);
  }
}

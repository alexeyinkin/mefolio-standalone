import 'package:model_interfaces/model_interfaces.dart';

class Role extends WithIdTitle<String> {
  Role(super.id, super.title);

  static Role fromIdAndMap(String id, Map<String, dynamic> map) {
    return Role(id, map['title'] ?? id);
  }
}

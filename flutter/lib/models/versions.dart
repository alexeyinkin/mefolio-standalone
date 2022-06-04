import 'package:version/version.dart';

class Versions {
  final Version min;

  const Versions({
    required this.min,
  });

  factory Versions.fromMap(Map<String, dynamic> map) {
    return Versions(
      min: Version.parse(map['min']),
    );
  }
}

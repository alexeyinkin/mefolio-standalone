class ProjectView {
  final int backgroundColor;
  final int textBackgroundColor;
  final int textColor;

  const ProjectView({
    required this.backgroundColor,
    required this.textBackgroundColor,
    required this.textColor,
  });

  static const defaultBackgroundColor = 0xFFFFFFFF;
  static const defaultTextBackgroundColor = 0x00000000;
  static const defaultTextColor = 0xFF000000;

  static const empty = ProjectView(
    backgroundColor: defaultBackgroundColor,
    textBackgroundColor: defaultTextBackgroundColor,
    textColor: defaultTextColor,
  );

  factory ProjectView.fromMapOrNull(Map<String, dynamic>? map) {
    if (map == null) return empty;

    return ProjectView(
      backgroundColor: int.tryParse(map['backgroundColor'] ?? '', radix: 16) ?? defaultBackgroundColor,
      textBackgroundColor: int.tryParse(map['textBackgroundColor'] ?? '', radix: 16) ?? defaultTextBackgroundColor,
      textColor: int.tryParse(map['textColor'] ?? '', radix: 16) ?? defaultTextColor,
    );
  }
}

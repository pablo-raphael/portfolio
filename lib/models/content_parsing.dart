const String missingTextPlaceholder = '[text not found]';

String readString(Map<String, dynamic>? json, String key) {
  final value = json?[key];
  if (value is String && value.trim().isNotEmpty) {
    return value;
  }
  return missingTextPlaceholder;
}

String? readOptionalString(Map<String, dynamic>? json, String key) {
  final value = json?[key];
  if (value is String && value.trim().isNotEmpty) {
    return value;
  }
  return null;
}

Map<String, dynamic> readMap(dynamic value) {
  if (value is Map) {
    return Map<String, dynamic>.from(value);
  }
  return const <String, dynamic>{};
}

List<Map<String, dynamic>> readMapList(dynamic value) {
  if (value is List) {
    return value
        .whereType<Map>()
        .map((entry) => Map<String, dynamic>.from(entry))
        .toList();
  }
  return const <Map<String, dynamic>>[];
}

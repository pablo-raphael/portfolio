import 'package:portfolio/models/content_parsing.dart';

class HeaderAnchor {
  const HeaderAnchor({required this.targetId, required this.label});

  final String targetId;
  final String label;

  factory HeaderAnchor.fromJson(Map<String, dynamic> json) {
    return HeaderAnchor(
      targetId: readString(json, 'targetId'),
      label: readString(json, 'label'),
    );
  }
}

class HeaderContent {
  const HeaderContent({required this.anchors});

  final List<HeaderAnchor> anchors;

  factory HeaderContent.fromJson(Map<String, dynamic> json) {
    final anchors = readMapList(
      json['anchors'],
    ).map(HeaderAnchor.fromJson).toList();
    return HeaderContent(anchors: anchors);
  }
}

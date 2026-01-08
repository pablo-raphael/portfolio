import 'package:portfolio/models/content_parsing.dart';

class SkillContent {
  const SkillContent({
    required this.name,
    required this.iconKey,
    required this.url,
  });

  final String name;
  final String iconKey;
  final String? url;

  factory SkillContent.fromJson(Map<String, dynamic> json) {
    return SkillContent(
      name: readString(json, 'name'),
      iconKey: readOptionalString(json, 'iconKey') ?? '',
      url: readOptionalString(json, 'url'),
    );
  }
}

class SkillsContent {
  const SkillsContent({required this.title, required this.items});

  final String title;
  final List<SkillContent> items;

  factory SkillsContent.fromJson(Map<String, dynamic> json) {
    final items = readMapList(
      json['items'],
    ).map(SkillContent.fromJson).toList();
    return SkillsContent(title: readString(json, 'title'), items: items);
  }
}

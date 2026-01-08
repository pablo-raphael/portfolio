import 'package:portfolio/models/content_parsing.dart';

class ExperienceItemContent {
  const ExperienceItemContent({
    required this.date,
    required this.role,
    required this.company,
    required this.description,
  });

  final String date;
  final String role;
  final String company;
  final String description;

  factory ExperienceItemContent.fromJson(Map<String, dynamic> json) {
    return ExperienceItemContent(
      date: readString(json, 'date'),
      role: readString(json, 'role'),
      company: readString(json, 'company'),
      description: readString(json, 'description'),
    );
  }
}

class ExperienceContent {
  const ExperienceContent({required this.title, required this.items});

  final String title;
  final List<ExperienceItemContent> items;

  factory ExperienceContent.fromJson(Map<String, dynamic> json) {
    final items = readMapList(
      json['items'],
    ).map(ExperienceItemContent.fromJson).toList();
    return ExperienceContent(title: readString(json, 'title'), items: items);
  }
}

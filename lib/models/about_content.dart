import 'package:portfolio/models/content_parsing.dart';

class AboutContent {
  const AboutContent({required this.title, required this.text});

  final String title;
  final String text;

  factory AboutContent.fromJson(Map<String, dynamic> json) {
    return AboutContent(
      title: readString(json, 'title'),
      text: readString(json, 'text'),
    );
  }
}

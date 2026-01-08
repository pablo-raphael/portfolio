import 'package:portfolio/models/content_parsing.dart';

class FooterContent {
  const FooterContent({required this.text});

  final String text;

  factory FooterContent.fromJson(Map<String, dynamic> json) {
    return FooterContent(text: readString(json, 'text'));
  }
}

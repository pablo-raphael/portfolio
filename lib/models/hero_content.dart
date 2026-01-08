import 'package:portfolio/models/content_parsing.dart';

class HeroContent {
  const HeroContent({
    required this.intro,
    required this.name,
    required this.role,
    required this.ctaLabel,
    required this.imageUrl,
  });

  final String intro;
  final String name;
  final String role;
  final String ctaLabel;
  final String? imageUrl;

  factory HeroContent.fromJson(Map<String, dynamic> json) {
    return HeroContent(
      intro: readString(json, 'intro'),
      name: readString(json, 'name'),
      role: readString(json, 'role'),
      ctaLabel: readString(json, 'ctaLabel'),
      imageUrl: readOptionalString(json, 'imageUrl'),
    );
  }
}

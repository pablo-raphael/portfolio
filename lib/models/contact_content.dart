import 'package:portfolio/models/content_parsing.dart';

class ContactMethodContent {
  const ContactMethodContent({
    required this.type,
    required this.label,
    required this.value,
  });

  final String type;
  final String label;
  final String value;

  factory ContactMethodContent.fromJson(Map<String, dynamic> json) {
    return ContactMethodContent(
      type: readString(json, 'type'),
      label: readString(json, 'label'),
      value: readString(json, 'value'),
    );
  }
}

class SocialLinkContent {
  const SocialLinkContent({required this.iconKey, required this.url});

  final String iconKey;
  final String? url;

  factory SocialLinkContent.fromJson(Map<String, dynamic> json) {
    return SocialLinkContent(
      iconKey: readOptionalString(json, 'iconKey') ?? '',
      url: readOptionalString(json, 'url'),
    );
  }
}

class ContactContent {
  const ContactContent({
    required this.title,
    required this.methods,
    required this.socialLinks,
  });

  final String title;
  final List<ContactMethodContent> methods;
  final List<SocialLinkContent> socialLinks;

  factory ContactContent.fromJson(Map<String, dynamic> json) {
    final methods = readMapList(
      json['methods'],
    ).map(ContactMethodContent.fromJson).toList();
    final socialLinks = readMapList(
      json['socialLinks'],
    ).map(SocialLinkContent.fromJson).toList();
    return ContactContent(
      title: readString(json, 'title'),
      methods: methods,
      socialLinks: socialLinks,
    );
  }
}

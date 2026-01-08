import 'package:portfolio/models/content_parsing.dart';

class TestimonialAuthorContent {
  const TestimonialAuthorContent({
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.url,
  });

  final String name;
  final String role;
  final String? imageUrl;
  final String? url;

  factory TestimonialAuthorContent.fromJson(Map<String, dynamic> json) {
    return TestimonialAuthorContent(
      name: readString(json, 'name'),
      role: readString(json, 'role'),
      imageUrl: readOptionalString(json, 'imageUrl'),
      url: readOptionalString(json, 'url'),
    );
  }
}

class TestimonialItemContent {
  const TestimonialItemContent({required this.text, required this.author});

  final String text;
  final TestimonialAuthorContent author;

  factory TestimonialItemContent.fromJson(Map<String, dynamic> json) {
    final author = readMap(json['author']);
    return TestimonialItemContent(
      text: readString(json, 'text'),
      author: TestimonialAuthorContent.fromJson(author),
    );
  }

  factory TestimonialItemContent.placeholder() {
    return TestimonialItemContent(
      text: missingTextPlaceholder,
      author: TestimonialAuthorContent(
        name: missingTextPlaceholder,
        role: missingTextPlaceholder,
        imageUrl: null,
        url: null,
      ),
    );
  }
}

class TestimonialsContent {
  const TestimonialsContent({required this.title, required this.items});

  final String title;
  final List<TestimonialItemContent> items;

  factory TestimonialsContent.fromJson(Map<String, dynamic> json) {
    final items = readMapList(
      json['items'],
    ).map(TestimonialItemContent.fromJson).toList();
    return TestimonialsContent(
      title: readString(json, 'title'),
      items: items.isEmpty ? [TestimonialItemContent.placeholder()] : items,
    );
  }
}

import 'package:portfolio/models/content_parsing.dart';

class PortfolioItemUrls {
  const PortfolioItemUrls({required this.live, required this.source});

  final String? live;
  final String? source;

  factory PortfolioItemUrls.fromJson(Map<String, dynamic> json) {
    return PortfolioItemUrls(
      live: readOptionalString(json, 'live'),
      source: readOptionalString(json, 'source'),
    );
  }
}

class PortfolioItemContent {
  const PortfolioItemContent({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.urls,
    required this.ctaLabel,
  });

  final String title;
  final String description;
  final String? imageUrl;
  final PortfolioItemUrls urls;
  final String? ctaLabel;

  factory PortfolioItemContent.fromJson(Map<String, dynamic> json) {
    final urls = readMap(json['urls']);
    return PortfolioItemContent(
      title: readString(json, 'title'),
      description: readString(json, 'description'),
      imageUrl: readOptionalString(json, 'imageUrl'),
      urls: PortfolioItemUrls.fromJson(urls),
      ctaLabel: readOptionalString(json, 'ctaLabel'),
    );
  }
}

class PortfolioCta {
  const PortfolioCta({
    required this.label,
    required this.url,
    required this.iconKey,
  });

  final String label;
  final String? url;
  final String iconKey;

  factory PortfolioCta.fromJson(Map<String, dynamic> json) {
    return PortfolioCta(
      label: readString(json, 'label'),
      url: readOptionalString(json, 'url'),
      iconKey: readOptionalString(json, 'iconKey') ?? '',
    );
  }
}

class PortfolioContent {
  const PortfolioContent({
    required this.title,
    required this.items,
    required this.viewMoreCta,
  });

  final String title;
  final List<PortfolioItemContent> items;
  final PortfolioCta viewMoreCta;

  factory PortfolioContent.fromJson(Map<String, dynamic> json) {
    final items = readMapList(
      json['items'],
    ).map(PortfolioItemContent.fromJson).toList();
    final cta = readMap(json['viewMoreCta']);
    return PortfolioContent(
      title: readString(json, 'title'),
      items: items,
      viewMoreCta: PortfolioCta.fromJson(cta),
    );
  }
}

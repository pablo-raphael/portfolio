import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/icon_mapper.dart';
import 'package:portfolio/core/utils/link_launcher.dart';
import 'package:portfolio/models/contact_content.dart';
import 'package:portfolio/ui/home/widgets/social_icon_button.dart';

class SocialLinks extends StatefulWidget {
  const SocialLinks({
    super.key,
    required this.links,
    required this.direction,
    required this.size,
    this.spacing = AppSpacing.sm,
    this.showAccentLine = false,
  });

  final List<SocialLinkContent> links;
  final Axis direction;
  final double size;
  final double spacing;
  final bool showAccentLine;

  static bool hasValidLinks(List<SocialLinkContent> links) {
    return links.any((link) => parseExternalUrl(link.url) != null);
  }

  @override
  State<SocialLinks> createState() => _SocialLinksState();
}

class _SocialLinksState extends State<SocialLinks> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final entries = widget.links
        .map((link) {
          final uri = parseExternalUrl(link.url);
          return uri == null ? null : _SocialLinkEntry(link: link, uri: uri);
        })
        .whereType<_SocialLinkEntry>()
        .toList();

    if (entries.isEmpty) {
      return const SizedBox.shrink();
    }

    final children = <Widget>[];

    if (widget.direction == Axis.vertical && widget.showAccentLine) {
      children.add(
        Container(width: AppSpacing.half, height: 70, color: AppColors.accent),
      );
      children.add(SizedBox(height: widget.spacing));
    }

    for (var i = 0; i < entries.length; i++) {
      children.add(
        SocialIconButton(
          icon: mapSocialIcon(entries[i].link.iconKey),
          isHighlighted: _hoveredIndex == i,
          size: widget.size,
          onEnter: () {
            setState(() {
              _hoveredIndex = i;
            });
          },
          onExit: () {
            setState(() {
              if (_hoveredIndex == i) {
                _hoveredIndex = null;
              }
            });
          },
          onTap: () => launchExternalUri(entries[i].uri),
        ),
      );
      if (i != entries.length - 1) {
        children.add(
          widget.direction == Axis.vertical
              ? SizedBox(height: widget.spacing)
              : SizedBox(width: widget.spacing),
        );
      }
    }

    return widget.direction == Axis.vertical
        ? Column(children: children)
        : Row(mainAxisSize: MainAxisSize.min, children: children);
  }
}

class _SocialLinkEntry {
  const _SocialLinkEntry({required this.link, required this.uri});

  final SocialLinkContent link;
  final Uri uri;
}

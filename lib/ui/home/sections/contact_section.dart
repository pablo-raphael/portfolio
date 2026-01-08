import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_layout.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/models/contact_content.dart';
import 'package:portfolio/ui/home/widgets/contact_info_card.dart';
import 'package:portfolio/ui/home/widgets/section_container.dart';
import 'package:portfolio/ui/home/widgets/social_links.dart';
import 'package:portfolio/core/utils/icon_mapper.dart';
import 'package:portfolio/core/utils/link_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.content});

  final ContactContent content;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = AppLayout.isMobile(screenWidth);
    final methodEntries = content.methods
        .map((method) {
          final uri = _buildContactUri(method);
          return uri == null
              ? null
              : _ContactMethodEntry(method: method, uri: uri);
        })
        .whereType<_ContactMethodEntry>()
        .toList();
    final hasSocialLinks = SocialLinks.hasValidLinks(content.socialLinks);

    return SectionContainer(
      backgroundColor: AppColors.background,
      child: Column(
        children: [
          _ContactHeader(title: content.title, isCompact: isCompact),
          const SizedBox(height: 26),
          _ContactMethods(entries: methodEntries, isCompact: isCompact),
          if (hasSocialLinks) ...[
            const SizedBox(height: AppSpacing.xxl),
            SocialLinks(
              links: content.socialLinks,
              direction: Axis.horizontal,
              size: isCompact ? AppSpacing.giant : AppSpacing.xxxxxl,
            ),
          ],
        ],
      ),
    );
  }
}

class _ContactHeader extends StatelessWidget {
  const _ContactHeader({required this.title, required this.isCompact});

  final String title;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    if (isCompact) {
      return Column(
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.md),
          Container(
            width: 60,
            height: AppSpacing.half,
            color: AppColors.accent,
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.accent, thickness: 1)),
        const SizedBox(width: AppSpacing.lg),
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(width: AppSpacing.lg),
        Expanded(child: Divider(color: AppColors.accent, thickness: 1)),
      ],
    );
  }
}

class _ContactMethods extends StatefulWidget {
  const _ContactMethods({required this.entries, required this.isCompact});

  final List<_ContactMethodEntry> entries;
  final bool isCompact;

  @override
  State<_ContactMethods> createState() => _ContactMethodsState();
}

class _ContactMethodsState extends State<_ContactMethods> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxCardWidth = widget.isCompact ? constraints.maxWidth : 320.0;
        return Wrap(
          spacing: AppSpacing.lg,
          runSpacing: AppSpacing.lg,
          alignment: WrapAlignment.center,
          children: [
            for (int i = 0; i < widget.entries.length; i++)
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxCardWidth),
                child: ContactInfoCard(
                  icon: mapContactMethodIcon(widget.entries[i].method.type),
                  label: widget.entries[i].method.label,
                  isHighlighted: _hoveredIndex == i,
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
                  onTap: () => launchExternalUri(widget.entries[i].uri),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _ContactMethodEntry {
  const _ContactMethodEntry({required this.method, required this.uri});

  final ContactMethodContent method;
  final Uri uri;
}

Uri? _buildContactUri(ContactMethodContent method) {
  switch (method.type) {
    case 'email':
      return buildEmailUri(method.value);
    case 'phone':
      return buildPhoneUri(method.value);
    case 'whatsapp':
      return buildWhatsAppUri(method.value);
    case 'location':
      return buildMapsUri(method.value);
    default:
      return parseExternalUrl(method.value);
  }
}

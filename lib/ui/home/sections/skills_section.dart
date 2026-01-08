import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_layout.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/models/skills_content.dart';
import 'package:portfolio/core/utils/link_launcher.dart';
import 'package:portfolio/ui/home/widgets/dot_pattern.dart';
import 'package:portfolio/ui/home/widgets/section_container.dart';
import 'package:portfolio/ui/home/widgets/section_title.dart';
import 'package:portfolio/ui/home/widgets/skill_card.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key, required this.content});

  final SkillsContent content;

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isCompact = AppLayout.isMobile(width);
    final cardWidth = isCompact ? AppSpacing.max : 140.0;
    final cardHeight = isCompact ? 118.0 : 132.0;

    return SectionContainer(
      backgroundColor: AppColors.background,
      child: Stack(
        children: [
          if (AppLayout.showDecorations(width))
            const Positioned(
              right: AppSpacing.sm,
              top: 140,
              child: IgnorePointer(
                child: DotPattern(
                  rows: 5,
                  columns: 4,
                  dotSize: AppSpacing.xs,
                  gap: AppSpacing.xxl,
                  color: AppColors.pattern,
                ),
              ),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: SectionTitle(title: widget.content.title),
              ),
              const SizedBox(height: AppSpacing.xxxl),
              Align(
                alignment: Alignment.center,
                child: Wrap(
                  spacing: AppSpacing.xl,
                  runSpacing: AppSpacing.xl,
                  alignment: WrapAlignment.center,
                  children: [
                    for (int i = 0; i < widget.content.items.length; i++)
                      SkillCard(
                        item: widget.content.items[i],
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
                        onTap: _buildTapHandler(widget.content.items[i]),
                        width: cardWidth,
                        height: cardHeight,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  VoidCallback? _buildTapHandler(SkillContent item) {
    final uri = parseExternalUrl(item.url);
    if (uri == null) {
      return null;
    }
    return () => launchExternalUri(uri);
  }
}

import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_layout.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/models/portfolio_content.dart';
import 'package:portfolio/core/utils/link_launcher.dart';
import 'package:portfolio/ui/home/widgets/dot_pattern.dart';
import 'package:portfolio/ui/home/widgets/portfolio_grid.dart';
import 'package:portfolio/ui/home/widgets/section_container.dart';
import 'package:portfolio/ui/home/widgets/section_title.dart';

class PortfolioSection extends StatelessWidget {
  const PortfolioSection({super.key, required this.content});

  final PortfolioContent content;

  @override
  Widget build(BuildContext context) {
    final items = content.items;
    final defaultCtaLabel = content.viewMoreCta.label;
    final viewMoreUri = parseExternalUrl(content.viewMoreCta.url);
    final width = MediaQuery.of(context).size.width;
    return SectionContainer(
      backgroundColor: AppColors.backgroundAlt,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (AppLayout.showDecorations(width))
            const Positioned(
              left: -AppSpacing.xxxl,
              bottom: 30,
              child: IgnorePointer(
                child: DotPattern(
                  rows: 4,
                  columns: 5,
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
                child: SectionTitle(title: content.title),
              ),
              const SizedBox(height: AppSpacing.xxxl),
              Align(
                alignment: Alignment.center,
                child: PortfolioGrid(
                  items: items,
                  defaultCtaLabel: defaultCtaLabel,
                ),
              ),
              if (viewMoreUri != null) ...[
                const SizedBox(height: AppSpacing.xxxl),
                Align(
                  alignment: Alignment.center,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: ElevatedButton(
                      onPressed: () => launchExternalUri(viewMoreUri),
                      child: Text(defaultCtaLabel),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

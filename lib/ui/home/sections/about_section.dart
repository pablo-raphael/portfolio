import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_layout.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';
import 'package:portfolio/core/design_system/app_typography.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/models/about_content.dart';
import 'package:portfolio/ui/home/widgets/section_container.dart';
import 'package:portfolio/ui/home/widgets/section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.content});

  final AboutContent content;

  @override
  Widget build(BuildContext context) {
    final isCompact = AppLayout.isMobile(MediaQuery.of(context).size.width);
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontSize: isCompact ? AppTypography.bodySmallSize : null,
      height: isCompact ? AppTypography.bodyCompactHeight : null,
    );

    return SectionContainer(
      backgroundColor: AppColors.backgroundAlt,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: content.title),
          const SizedBox(height: AppSpacing.lg),
          Text(content.text, style: textStyle),
        ],
      ),
    );
  }
}

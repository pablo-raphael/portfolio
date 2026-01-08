import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_layout.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';
import 'package:portfolio/core/theme/app_colors.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.centered = false,
    this.showLine = true,
  });

  final String title;
  final bool centered;
  final bool showLine;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isCompact = AppLayout.isMobile(width);
    final style = Theme.of(context).textTheme.headlineMedium?.copyWith(
      fontSize: isCompact ? AppSpacing.xxl : null,
    );

    return Column(
      crossAxisAlignment: centered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: style,
          textAlign: centered ? TextAlign.center : TextAlign.left,
        ),
        if (showLine) ...[
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: AppSpacing.xxxxxl,
            height: 2,
            color: AppColors.accent,
          ),
        ],
      ],
    );
  }
}

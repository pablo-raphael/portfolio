import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/models/footer_content.dart';
import 'package:portfolio/ui/home/widgets/section_container.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key, required this.content});

  final FooterContent content;

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      backgroundColor: AppColors.backgroundAlt,
      verticalPadding: AppSpacing.xxl,
      child: Center(
        child: Text(
          content.text,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.accent,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

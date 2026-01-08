import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_layout.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/models/experience_content.dart';
import 'package:portfolio/ui/home/widgets/experience_entry.dart';
import 'package:portfolio/ui/home/widgets/section_container.dart';
import 'package:portfolio/ui/home/widgets/section_title.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key, required this.content});

  final ExperienceContent content;

  @override
  Widget build(BuildContext context) {
    final experiences = content.items;
    final isCompact = AppLayout.isMobile(MediaQuery.of(context).size.width);

    return SectionContainer(
      backgroundColor: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: content.title),
          const SizedBox(height: AppSpacing.xxl),
          Stack(
            children: [
              if (!isCompact)
                Positioned(
                  left: 45,
                  top: AppSpacing.xxl,
                  bottom: 0,
                  child: Container(
                    width: AppSpacing.half,
                    color: AppColors.divider,
                  ),
                ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < experiences.length; i++) ...[
                      ExperienceEntry(
                        item: experiences[i],
                        isCompact: isCompact,
                      ),
                      if (i != experiences.length - 1)
                        SizedBox(
                          height: isCompact ? AppSpacing.xxl : AppSpacing.huge,
                        ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

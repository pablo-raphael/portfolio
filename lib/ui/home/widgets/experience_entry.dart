import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_radii.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';
import 'package:portfolio/core/design_system/app_typography.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/models/experience_content.dart';

class ExperienceEntry extends StatelessWidget {
  const ExperienceEntry({
    super.key,
    required this.item,
    required this.isCompact,
  });

  final ExperienceItemContent item;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final descriptionStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontSize: isCompact ? AppTypography.bodyTinySize : null,
      height: isCompact ? AppTypography.bodyTightHeight : null,
    );

    if (isCompact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DateChip(date: item.date, isCompact: true),
          const SizedBox(height: AppSpacing.sm),
          Text(
            item.role,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            item.company,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(item.description, style: descriptionStyle),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Column(
            children: [
              _DateChip(date: item.date, isCompact: false),
              const SizedBox(height: AppSpacing.md),
              Container(
                width: AppSpacing.md,
                height: AppSpacing.md,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.role,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                item.company,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(item.description, style: descriptionStyle),
            ],
          ),
        ),
      ],
    );
  }
}

class _DateChip extends StatelessWidget {
  const _DateChip({required this.date, required this.isCompact});

  final String date;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.xs),
      ),
      child: Text(
        date,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: isCompact ? AppColors.accent : AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

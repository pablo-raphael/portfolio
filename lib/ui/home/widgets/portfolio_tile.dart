import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_durations.dart';
import 'package:portfolio/core/design_system/app_opacity.dart';
import 'package:portfolio/core/design_system/app_radii.dart';
import 'package:portfolio/core/design_system/app_shadows.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/models/portfolio_content.dart';
import 'package:portfolio/core/utils/link_launcher.dart';

class PortfolioTile extends StatelessWidget {
  const PortfolioTile({
    super.key,
    required this.item,
    required this.isHovered,
    required this.ctaLabel,
    required this.sourceUri,
  });

  final PortfolioItemContent item;
  final bool isHovered;
  final String ctaLabel;
  final Uri? sourceUri;

  @override
  Widget build(BuildContext context) {
    final overlayTop = AppColors.surfaceDark.withValues(alpha: 0.8);
    final overlayBottom = AppColors.surfaceDark.withValues(
      alpha: AppOpacity.alpha60,
    );
    final imageUrl = item.imageUrl;

    return AnimatedContainer(
      duration: AppDurations.fast,
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.md),
        boxShadow: [if (isHovered) AppShadows.cardStrong],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.md),
        child: Stack(
          fit: StackFit.expand,
          children: [
            imageUrl == null
                ? Container(
                    color: AppColors.surface,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.image_outlined,
                      size: AppSpacing.huge,
                    ),
                  )
                : Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      color: AppColors.surface,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.broken_image_outlined,
                        size: AppSpacing.huge,
                      ),
                    ),
                  ),
            AnimatedOpacity(
              duration: AppDurations.fast,
              opacity: isHovered ? 1 : 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [overlayTop, overlayBottom],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: AppSpacing.xl,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      item.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    if (sourceUri != null)
                      SizedBox(
                        height: 30,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.lg,
                              ),
                              textStyle: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            onPressed: () => launchExternalUri(sourceUri),
                            child: Text(ctaLabel),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

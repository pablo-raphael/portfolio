import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_layout.dart';
import 'package:portfolio/core/design_system/app_radii.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';
import 'package:portfolio/core/design_system/app_typography.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/models/contact_content.dart';
import 'package:portfolio/models/hero_content.dart';
import 'package:portfolio/ui/home/widgets/social_links.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.content,
    required this.socialLinks,
    required this.onContactTap,
  });

  final HeroContent content;
  final List<SocialLinkContent> socialLinks;
  final VoidCallback onContactTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final horizontalPadding = AppLayout.horizontalPadding(
            constraints.maxWidth,
          );
          final verticalPadding = AppSpacing.xxl;
          final isNarrow = AppLayout.isNarrow(constraints.maxWidth);
          final isCompact = AppLayout.isMobile(constraints.maxWidth);
          final imageMaxWidth = constraints.maxWidth * 0.66;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppLayout.maxContentWidth,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: horizontalPadding,
                  right: horizontalPadding,
                  top: verticalPadding,
                ),
                child: Stack(
                  children: [
                    if (isNarrow)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: AppSpacing.xxl,
                        children: [
                          _HeroCopy(
                            content: content,
                            onContactTap: onContactTap,
                            socialLinks: socialLinks,
                            showSocialRow: isCompact,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: _HeroImage(
                              imageUrl: content.imageUrl,
                              maxWidth: imageMaxWidth,
                            ),
                          ),
                        ],
                      )
                    else
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(
                                  bottom: verticalPadding,
                                ),
                                child: _HeroCopy(
                                  content: content,
                                  onContactTap: onContactTap,
                                  socialLinks: socialLinks,
                                  showSocialRow: false,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: _HeroImage(
                                  imageUrl: content.imageUrl,
                                  maxWidth: imageMaxWidth,
                                ),
                              ),
                            ),
                            Flexible(flex: 1, child: SizedBox.shrink()),
                          ],
                        ),
                      ),
                    if (!isCompact && SocialLinks.hasValidLinks(socialLinks))
                      Positioned(
                        right: 0,
                        bottom: verticalPadding,
                        child: SocialLinks(
                          links: socialLinks,
                          direction: Axis.vertical,
                          size: AppSpacing.xxxxxl,
                          showAccentLine: true,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({
    required this.content,
    required this.onContactTap,
    required this.socialLinks,
    required this.showSocialRow,
  });

  final HeroContent content;
  final VoidCallback onContactTap;
  final List<SocialLinkContent> socialLinks;
  final bool showSocialRow;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = AppLayout.isMobile(screenWidth);
    final isNarrow = AppLayout.isNarrow(screenWidth);
    final headline = Theme.of(context).textTheme.displayLarge;
    final introSize = isCompact
        ? AppTypography.heroIntroMobile
        : isNarrow
        ? AppTypography.heroIntroTablet
        : AppTypography.heroIntroDesktop;
    final nameSize = isCompact
        ? AppTypography.heroNameMobile
        : isNarrow
        ? AppTypography.heroNameTablet
        : AppTypography.heroNameDesktop;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${content.intro} ',
                style: headline?.copyWith(
                  fontSize: introSize,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: content.name,
                style: headline?.copyWith(
                  fontSize: nameSize,
                  color: AppColors.accent,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          content.role,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textPrimary,
            height: AppTypography.bodyTightHeight,
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
        OutlinedButton(onPressed: onContactTap, child: Text(content.ctaLabel)),
        if (showSocialRow && SocialLinks.hasValidLinks(socialLinks)) ...[
          const SizedBox(height: AppSpacing.xl),
          SocialLinks(
            links: socialLinks,
            direction: Axis.horizontal,
            size: AppSpacing.giant,
          ),
        ],
      ],
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({required this.imageUrl, required this.maxWidth});

  final String? imageUrl;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.trim().isNotEmpty;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.lg),
        child: AspectRatio(
          aspectRatio: 1,
          child: hasImage
              ? Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    color: AppColors.surface,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.broken_image_outlined,
                      size: AppSpacing.mega,
                    ),
                  ),
                )
              : Container(
                  color: AppColors.surface,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.image_outlined,
                    size: AppSpacing.mega,
                  ),
                ),
        ),
      ),
    );
  }
}

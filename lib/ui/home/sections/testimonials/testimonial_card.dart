import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_layout.dart';
import 'package:portfolio/core/design_system/app_radii.dart';
import 'package:portfolio/core/design_system/app_shadows.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';
import 'package:portfolio/core/design_system/app_typography.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/link_launcher.dart';
import 'package:portfolio/models/testimonials_content.dart';

class TestimonialCard extends StatelessWidget {
  const TestimonialCard({
    super.key,
    required this.item,
    required this.isMobile,
    required this.showFullText,
  });

  final TestimonialItemContent item;
  final bool isMobile;
  final bool showFullText;

  @override
  Widget build(BuildContext context) {
    final isCompact = AppLayout.isMobile(MediaQuery.of(context).size.width);
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.textMuted,
      height: AppTypography.bodyLargeHeight,
    );
    final mobileTextStyle = textStyle?.copyWith(
      fontSize: AppTypography.bodySmallSize,
      height: AppTypography.bodyCompactHeight,
    );
    final authorUri = parseExternalUrl(item.author.url);

    final effectiveTextStyle = isCompact ? mobileTextStyle : textStyle;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: [AppShadows.card],
      ),
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.text,
                  style: effectiveTextStyle,
                  maxLines: showFullText ? null : 3,
                  overflow: showFullText
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.lg),
                const Spacer(),
                Row(
                  children: [
                    _AuthorPhoto(
                      imageUrl: item.author.imageUrl,
                      size: 60,
                      onTap: authorUri == null
                          ? null
                          : () => launchExternalUri(authorUri),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: _AuthorInfo(
                        name: item.author.name,
                        role: item.author.role,
                        onTap: authorUri == null
                            ? null
                            : () => launchExternalUri(authorUri),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.text,
                        style: effectiveTextStyle,
                        maxLines: showFullText ? null : 5,
                        overflow: showFullText
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      const Spacer(),
                      _AuthorInfo(
                        name: item.author.name,
                        role: item.author.role,
                        onTap: authorUri == null
                            ? null
                            : () => launchExternalUri(authorUri),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.xxxxl),
                _PhotoStack(
                  imageUrl: item.author.imageUrl,
                  onTap: authorUri == null
                      ? null
                      : () => launchExternalUri(authorUri),
                ),
              ],
            ),
    );
  }
}

class _AuthorInfo extends StatelessWidget {
  const _AuthorInfo({
    required this.name,
    required this.role,
    required this.onTap,
  });

  final String name;
  final String role;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final nameStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600,
    );
    final roleStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted);
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: nameStyle),
        const SizedBox(height: AppSpacing.xs),
        Text(role, style: roleStyle),
      ],
    );

    if (onTap == null) {
      return content;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(onTap: onTap, child: content),
    );
  }
}

class _AuthorPhoto extends StatelessWidget {
  const _AuthorPhoto({required this.imageUrl, this.size = 56, this.onTap});

  final String? imageUrl;
  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final border = BorderRadius.circular(AppRadii.lg);

    final content = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: border,
        color: AppColors.surfaceDark.withValues(alpha: 0.12),
      ),
      clipBehavior: Clip.antiAlias,
      child: imageUrl == null
          ? Container(
              color: AppColors.surface,
              alignment: Alignment.center,
              child: const Icon(Icons.image_outlined, size: 26),
            )
          : Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                color: AppColors.surface,
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image_outlined, size: 26),
              ),
            ),
    );

    if (onTap == null) {
      return content;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(onTap: onTap, child: content),
    );
  }
}

class _PhotoStack extends StatelessWidget {
  const _PhotoStack({required this.imageUrl, this.onTap});

  final String? imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const size = 240.0;
    final radius = BorderRadius.circular(AppRadii.lg);

    final content = SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: AppSpacing.sm,
            top: AppSpacing.sm,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: radius,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: radius,
            child: SizedBox(
              width: size,
              height: size,
              child: imageUrl == null
                  ? Container(
                      color: AppColors.surface,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.image_outlined,
                        size: AppSpacing.huge,
                      ),
                    )
                  : Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      alignment: const Alignment(0.0, -0.2),
                      errorBuilder: (_, _, _) => Container(
                        color: AppColors.surface,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.broken_image_outlined,
                          size: AppSpacing.huge,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );

    if (onTap == null) {
      return content;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(onTap: onTap, child: content),
    );
  }
}

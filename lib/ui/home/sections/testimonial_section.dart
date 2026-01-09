import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_durations.dart';
import 'package:portfolio/core/design_system/app_layout.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';
import 'package:portfolio/core/design_system/app_typography.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/models/testimonials_content.dart';
import 'package:portfolio/ui/home/widgets/dot_pattern.dart';
import 'package:portfolio/ui/home/widgets/section_container.dart';
import 'package:portfolio/ui/home/widgets/section_title.dart';
import 'package:portfolio/ui/home/sections/testimonials/testimonial_card.dart';
import 'package:portfolio/ui/home/sections/testimonials/testimonial_carousel_controls.dart';

class TestimonialSection extends StatefulWidget {
  const TestimonialSection({super.key, required this.content});

  final TestimonialsContent content;

  @override
  State<TestimonialSection> createState() => _TestimonialSectionState();
}

class _TestimonialSectionState extends State<TestimonialSection> {
  late PageController _controller;
  double _viewportFraction = 0.62;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: _viewportFraction);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TestimonialSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    final itemCount = widget.content.items.length;
    if (itemCount == 0) {
      _currentIndex = 0;
      return;
    }
    final clamped = _currentIndex.clamp(0, itemCount - 1);
    if (clamped != _currentIndex) {
      _currentIndex = clamped;
      if (_controller.hasClients) {
        _controller.jumpToPage(_currentIndex);
      }
    }
  }

  bool get _canNavigate => widget.content.items.length > 1;

  void _setViewportFraction(double value) {
    if ((value - _viewportFraction).abs() < 0.001) {
      return;
    }
    final targetPage = _controller.hasClients
        ? (_controller.page?.round() ?? _currentIndex)
        : _currentIndex;
    _viewportFraction = value;
    _controller.dispose();
    _controller = PageController(
      viewportFraction: _viewportFraction,
      initialPage: targetPage,
    );
    setState(() {});
  }

  void _goToPage(int index) {
    final items = widget.content.items;
    if (items.isEmpty) {
      return;
    }
    final target = index.clamp(0, items.length - 1);
    if (target == _currentIndex) {
      return;
    }
    _controller.animateToPage(
      target,
      duration: AppDurations.medium,
      curve: Curves.easeOutCubic,
    );
  }

  double _currentPage() {
    if (!_controller.hasClients) {
      return _currentIndex.toDouble();
    }
    return _controller.page ?? _currentIndex.toDouble();
  }

  double _measureTextHeight(
    BuildContext context,
    String text,
    TextStyle? style,
    double maxWidth,
  ) {
    if (maxWidth <= 0) {
      return 0;
    }
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
    )..layout(maxWidth: maxWidth);
    return textPainter.height;
  }

  double _estimateCardHeight(
    BuildContext context,
    TestimonialItemContent item,
    bool isMobile,
    bool isCompact,
    double cardWidth,
  ) {
    const cardPadding = AppSpacing.xxl;
    final photoSize = isCompact ? 200.0 : 240.0;
    final photoSpacing = isCompact ? AppSpacing.xl : AppSpacing.xxxxl;
    const authorAvatarSize = 60.0;
    const textToAuthorSpacing = AppSpacing.lg;
    const nameRoleSpacing = AppSpacing.xs;

    final contentWidth = cardWidth - (cardPadding * 2);
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.textMuted,
      height: AppTypography.bodyLargeHeight,
    );
    final compactTextStyle = textStyle?.copyWith(
      fontSize: AppTypography.bodySmallSize,
      height: AppTypography.bodyCompactHeight,
    );
    final effectiveTextStyle = isCompact ? compactTextStyle : textStyle;
    final nameStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600,
    );
    final roleStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted);

    if (isMobile) {
      final textHeight = _measureTextHeight(
        context,
        item.text,
        effectiveTextStyle,
        contentWidth,
      );
      final authorTextWidth = math.max(
        0.0,
        contentWidth - authorAvatarSize - AppSpacing.md,
      );
      final nameHeight = _measureTextHeight(
        context,
        item.author.name,
        nameStyle,
        authorTextWidth,
      );
      final roleHeight = _measureTextHeight(
        context,
        item.author.role,
        roleStyle,
        authorTextWidth,
      );
      final authorTextHeight = nameHeight + nameRoleSpacing + roleHeight;
      final authorRowHeight = math.max(authorAvatarSize, authorTextHeight);
      final contentHeight = textHeight + textToAuthorSpacing + authorRowHeight;
      return contentHeight + (cardPadding * 2);
    }

    final textColumnWidth = math.max(
      0.0,
      contentWidth - photoSize - photoSpacing,
    );
    final textHeight = _measureTextHeight(
      context,
      item.text,
      effectiveTextStyle,
      textColumnWidth,
    );
    final nameHeight = _measureTextHeight(
      context,
      item.author.name,
      nameStyle,
      textColumnWidth,
    );
    final roleHeight = _measureTextHeight(
      context,
      item.author.role,
      roleStyle,
      textColumnWidth,
    );
    final textColumnHeight =
        textHeight +
        textToAuthorSpacing +
        nameHeight +
        nameRoleSpacing +
        roleHeight;
    final contentHeight = math.max(textColumnHeight, photoSize);
    return contentHeight + (cardPadding * 2);
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.content.items;
    final safeIndex = items.isEmpty
        ? 0
        : _currentIndex.clamp(0, items.length - 1);

    return Container(
      color: AppColors.backgroundAlt,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = AppLayout.isNarrow(constraints.maxWidth);
          final isCompact = AppLayout.isMobile(constraints.maxWidth);
          final targetFraction = isCompact
              ? 0.94
              : isMobile
              ? 0.82
              : 0.62;
          if ((targetFraction - _viewportFraction).abs() > 0.001) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                _setViewportFraction(targetFraction);
              }
            });
          }

          final baseCardHeight = isCompact
              ? 360.0
              : isMobile
              ? 420.0
              : 360.0;
          final cardPadding = isCompact
              ? AppSpacing.sm
              : isMobile
              ? AppSpacing.md
              : AppSpacing.lg;
          final cardShadowSpace = AppSpacing.xxl;
          final screenWidth = constraints.maxWidth;
          final cardWidth =
              (screenWidth * _viewportFraction) - (cardPadding * 2);
          final estimatedCardHeight = items.isEmpty
              ? baseCardHeight
              : _estimateCardHeight(
                  context,
                  items[safeIndex],
                  isMobile,
                  isCompact,
                  cardWidth,
                );
          final cardHeight = math.max(baseCardHeight, estimatedCardHeight);
          final scrollBehavior = ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.trackpad,
            },
          );

          return Stack(
            children: [
              if (AppLayout.showDecorations(constraints.maxWidth))
                const Positioned(
                  right: 0,
                  bottom: AppSpacing.huge,
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacing.giga),
                  SectionContainer(
                    backgroundColor: Colors.transparent,
                    verticalPadding: 0,
                    child: SizedBox(
                      width: double.infinity,
                      child: SectionTitle(title: widget.content.title),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  SizedBox(
                    height: cardHeight + (cardShadowSpace * 2),
                    width: screenWidth,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTapUp: _canNavigate
                          ? (details) {
                              final pageWidth = screenWidth * _viewportFraction;
                              final leftEdge = (screenWidth - pageWidth) / 2;
                              final rightEdge = leftEdge + pageWidth;
                              final dx = details.localPosition.dx;
                              if (dx < leftEdge && _currentIndex > 0) {
                                _goToPage(_currentIndex - 1);
                              } else if (dx > rightEdge &&
                                  _currentIndex < items.length - 1) {
                                _goToPage(_currentIndex + 1);
                              }
                            }
                          : null,
                      child: ScrollConfiguration(
                        behavior: scrollBehavior,
                        child: PageView.builder(
                          controller: _controller,
                          physics: const PageScrollPhysics(),
                          itemCount: items.length,
                          onPageChanged: (index) {
                            setState(() => _currentIndex = index);
                          },
                          itemBuilder: (context, index) {
                            return AnimatedBuilder(
                              animation: _controller,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: cardPadding,
                                  vertical: cardShadowSpace,
                                ),
                                child: TestimonialCard(
                                  item: items[index],
                                  isMobile: isMobile,
                                  showFullText: index == safeIndex,
                                ),
                              ),
                              builder: (context, child) {
                                final page = _currentPage();
                                final distance = (index - page).abs();
                                final t = distance.clamp(0.0, 1.0);
                                final scale = lerpDouble(1.0, 0.86, t)!;
                                final opacity = lerpDouble(1.0, 0.55, t)!;
                                final blur = lerpDouble(0.0, 2.4, t)!;
                                final direction = index < page ? -1.0 : 1.0;
                                final translateX =
                                    lerpDouble(0.0, AppSpacing.xxl, t)! *
                                    direction;
                                final translateY = lerpDouble(
                                  0.0,
                                  AppSpacing.sm,
                                  t,
                                )!;

                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: _canNavigate && index != _currentIndex
                                      ? () => _goToPage(index)
                                      : null,
                                  child: Transform.translate(
                                    offset: Offset(translateX, translateY),
                                    child: Transform.scale(
                                      scale: scale,
                                      child: Opacity(
                                        opacity: opacity,
                                        child: ImageFiltered(
                                          imageFilter: ImageFilter.blur(
                                            sigmaX: blur,
                                            sigmaY: blur,
                                          ),
                                          child: child,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  SectionContainer(
                    backgroundColor: Colors.transparent,
                    verticalPadding: 0,
                    child: TestimonialCarouselControls(
                      itemCount: items.length,
                      currentIndex: _currentIndex,
                      onDotTap: _canNavigate ? _goToPage : null,
                      onPrevious: _canNavigate && _currentIndex > 0
                          ? () => _goToPage(_currentIndex - 1)
                          : null,
                      onNext: _canNavigate && _currentIndex < items.length - 1
                          ? () => _goToPage(_currentIndex + 1)
                          : null,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.giga),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

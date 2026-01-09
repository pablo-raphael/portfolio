import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_layout.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';
import 'package:portfolio/core/utils/link_launcher.dart';
import 'package:portfolio/models/portfolio_content.dart';
import 'package:portfolio/ui/home/widgets/portfolio_tile.dart';

class PortfolioGrid extends StatefulWidget {
  const PortfolioGrid({
    super.key,
    required this.items,
    required this.defaultCtaLabel,
  });

  final List<PortfolioItemContent> items;
  final String defaultCtaLabel;

  @override
  State<PortfolioGrid> createState() => _PortfolioGridState();
}

class _PortfolioGridState extends State<PortfolioGrid> {
  int? _hoveredIndex;
  bool _hasHoverDevice = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = AppLayout.isMobile(constraints.maxWidth);
        final spacing = isCompact ? AppSpacing.md : AppSpacing.xl;
        const maxTileWidth = 380.0;
        const aspectRatio = 1.5;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: widget.items.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: maxTileWidth,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: aspectRatio,
          ),
          itemBuilder: (context, index) {
            final item = widget.items[index];
            return MouseRegion(
              onEnter: (_) {
                setState(() {
                  _hasHoverDevice = true;
                  _hoveredIndex = index;
                });
              },
              onExit: (_) {
                setState(() => _hoveredIndex = null);
              },
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _hasHoverDevice
                    ? null
                    : () => setState(
                        () => _hoveredIndex = _hoveredIndex == index
                            ? null
                            : index,
                      ),
                child: PortfolioTile(
                  item: item,
                  isHovered: _hoveredIndex == index,
                  ctaLabel: item.ctaLabel ?? widget.defaultCtaLabel,
                  sourceUri: parseExternalUrl(item.urls.source),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

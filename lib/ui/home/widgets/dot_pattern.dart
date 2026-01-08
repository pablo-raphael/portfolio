import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';

class DotPattern extends StatelessWidget {
  const DotPattern({
    super.key,
    this.rows = 5,
    this.columns = 5,
    this.dotSize = AppSpacing.xs,
    this.gap = AppSpacing.md,
    required this.color,
  });

  final int rows;
  final int columns;
  final double dotSize;
  final double gap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(rows, (rowIndex) {
        return Padding(
          padding: EdgeInsets.only(bottom: rowIndex == rows - 1 ? 0 : gap),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(columns, (colIndex) {
              return Padding(
                padding: EdgeInsets.only(
                  right: colIndex == columns - 1 ? 0 : gap,
                ),
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}

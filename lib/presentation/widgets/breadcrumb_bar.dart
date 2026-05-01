// lib/presentation/widgets/breadcrumb_bar.dart
// Barra de breadcrumbs clickeables.
// Cada segmento puede llevar un onTap; el último se renderiza "activo" (bold).

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BreadcrumbSegment {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;

  const BreadcrumbSegment({
    required this.label,
    this.onTap,
    this.icon,
  });
}

class BreadcrumbBar extends StatelessWidget {
  final List<BreadcrumbSegment> segments;
  final EdgeInsets padding;

  const BreadcrumbBar({
    super.key,
    required this.segments,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mutedColor = isDark ? const Color(0xFF8E8E93) : const Color(0xFF6C6C70);
    final activeColor = Theme.of(context).colorScheme.onSurface;
    final separatorColor = isDark ? const Color(0xFF4A4A6A) : const Color(0xFFC7C7CC);

    final children = <Widget>[];
    for (var i = 0; i < segments.length; i++) {
      final seg = segments[i];
      final isLast = i == segments.length - 1;
      final tappable = !isLast && seg.onTap != null;

      children.add(
        Flexible(
          child: InkWell(
            onTap: tappable ? seg.onTap : null,
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (seg.icon != null) ...[
                    Icon(
                      seg.icon,
                      size: 14,
                      color: isLast ? activeColor : mutedColor,
                    ),
                    const SizedBox(width: 4),
                  ],
                  Flexible(
                    child: Text(
                      seg.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.5,
                        fontWeight: isLast ? FontWeight.w800 : FontWeight.w600,
                        color: isLast
                            ? activeColor
                            : (tappable ? Theme.of(context).colorScheme.primary : mutedColor),
                        decoration: tappable ? TextDecoration.underline : null,
                        decorationColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      if (!isLast) {
        children.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Icon(Icons.chevron_right_rounded, size: 16, color: separatorColor),
          ),
        );
      }
    }

    return Padding(
      padding: padding,
      child: Row(children: children),
    );
  }
}

import 'package:flutter/material.dart';
import '../utils/responsive.dart';

/// Centers content and clamps its width on large screens, with
/// consistent horizontal/vertical padding that scales down on mobile.
/// When [backgroundColor] or [backgroundGradient] is set, the section
/// is rendered as a full-bleed tint/gradient over the shared page
/// background, muting the photo enough for its content to stay readable.
class SectionContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final EdgeInsetsGeometry? verticalPadding;

  const SectionContainer({
    super.key,
    required this.child,
    this.backgroundColor,
    this.backgroundGradient,
    this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundGradient == null ? backgroundColor : null,
        gradient: backgroundGradient,
      ),
      padding: verticalPadding ??
          EdgeInsets.symmetric(
            vertical: isMobile ? 16 : 28,
            horizontal: isMobile ? 20 : 24,
          ),
      child: Center(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: Responsive.contentMaxWidth(context)),
          child: child,
        ),
      ),
    );
  }
}

/// A small gold divider rule used under section titles.
class GoldRule extends StatelessWidget {
  const GoldRule({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 70,
      height: 3,
      decoration: BoxDecoration(
        color: const Color(0xFFC9A227),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

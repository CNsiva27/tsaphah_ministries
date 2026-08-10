import 'package:flutter/material.dart';

/// Fades and slides [child] into place the first time it scrolls
/// within 90% of the viewport height. Must be placed inside a
/// [Scrollable] (e.g. the page's SingleChildScrollView).
class RevealOnScroll extends StatefulWidget {
  final Widget child;

  const RevealOnScroll({super.key, required this.child});

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> {
  bool _visible = false;
  ScrollPosition? _position;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final position = Scrollable.of(context).position;
    if (position != _position) {
      _position?.removeListener(_checkVisibility);
      _position = position;
      _position!.addListener(_checkVisibility);
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
    }
  }

  void _checkVisibility() {
    if (_visible || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) return;

    final viewportHeight = MediaQuery.of(context).size.height;
    final top = box.localToGlobal(Offset.zero).dy;
    if (top < viewportHeight * 0.9) {
      setState(() => _visible = true);
    }
  }

  @override
  void dispose() {
    _position?.removeListener(_checkVisibility);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      child: AnimatedSlide(
        offset: _visible ? Offset.zero : const Offset(0, 0.06),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

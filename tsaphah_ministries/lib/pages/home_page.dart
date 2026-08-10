import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/site_header.dart';
import '../widgets/hero_section.dart';
import '../widgets/gallery_section.dart';
import '../widgets/about_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/reveal_on_scroll.dart';

/// The single home page of the Tsaphah Ministries app. Holds the
/// GlobalKeys used to scroll to each section when a nav item /
/// drawer item is tapped.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
  final _contentKey = GlobalKey();

  final _homeKey = GlobalKey();
  final _galleryKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _contactKey = GlobalKey();

  double _fillerHeight = 0;

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  // If the page content is shorter than the viewport, the fixed
  // background photo behind it would peek out below the last section.
  // Measure the gap after each frame and fill it with a matching navy
  // tint so the photo never shows through bare.
  void _measureContentGap(double viewportHeight) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final box = _contentKey.currentContext?.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) return;
      final gap =
          (viewportHeight - box.size.height).clamp(0.0, double.infinity);
      if (gap != _fillerHeight) {
        setState(() => _fillerHeight = gap);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      appBar: SiteHeader(
        onHomeTap: () => _scrollTo(_homeKey),
        onGalleryTap: () => _scrollTo(_galleryKey),
        onAboutTap: () => _scrollTo(_aboutKey),
        onContactTap: () => _scrollTo(_contactKey),
        onMenuTap: () => _scaffoldKey.currentState?.openEndDrawer(),
      ),
      endDrawer: SiteDrawer(
        onHomeTap: () => _scrollTo(_homeKey),
        onGalleryTap: () => _scrollTo(_galleryKey),
        onAboutTap: () => _scrollTo(_aboutKey),
        onContactTap: () => _scrollTo(_contactKey),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final viewportHeight = constraints.maxHeight;
              final extraHeight = viewportHeight * 0.2;
              return AnimatedBuilder(
                animation: _scrollController,
                builder: (context, child) {
                  final offset = _scrollController.hasClients
                      ? _scrollController.offset
                      : 0.0;
                  final shift = (-offset * 0.1).clamp(-extraHeight, 0.0);
                  return ClipRect(
                    child: OverflowBox(
                      maxHeight: viewportHeight + extraHeight,
                      alignment: Alignment.topCenter,
                      child: Transform.translate(
                        offset: Offset(0, shift),
                        child: child,
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  height: viewportHeight + extraHeight,
                  width: double.infinity,
                  child: Image.asset('assets/images/church_hero.jpeg',
                      fit: BoxFit.cover),
                ),
              );
            },
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              _measureContentGap(constraints.maxHeight);
              return SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      key: _contentKey,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        KeyedSubtree(
                          key: _homeKey,
                          child: const RevealOnScroll(child: HeroSection()),
                        ),
                        KeyedSubtree(
                          key: _galleryKey,
                          child: const RevealOnScroll(child: GallerySection()),
                        ),
                        KeyedSubtree(
                          key: _aboutKey,
                          child: const RevealOnScroll(child: AboutSection()),
                        ),
                        KeyedSubtree(
                          key: _contactKey,
                          child: const RevealOnScroll(child: ContactSection()),
                        ),
                      ],
                    ),
                    if (_fillerHeight > 0)
                      Container(
                        height: _fillerHeight,
                        color: AppColors.navy.withValues(alpha: 0.9),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_fonts.dart';
import '../utils/responsive.dart';

/// The source logo asset is a large square (thousands of px) so it
/// stays crisp at any size. Decoding it at full resolution just to
/// paint a small circular avatar wastes memory and bandwidth, so we
/// tell the image cache to decode at the actual display size scaled
/// by the device's pixel ratio — Flutter's standard fix for this via
/// [Image.cacheWidth]/[Image.cacheHeight].
int logoCacheDimension(BuildContext context, double displaySize) {
  return (displaySize * MediaQuery.of(context).devicePixelRatio).round();
}

/// Top banner: logo + ministry name on the left, menu on the right.
/// On mobile the menu collapses into a hamburger that opens the
/// Scaffold's endDrawer (wired up by HomePage).
class SiteHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onGalleryTap;
  final VoidCallback onAboutTap;
  final VoidCallback onContactTap;
  final VoidCallback onMenuTap;

  const SiteHeader({
    super.key,
    required this.onHomeTap,
    required this.onGalleryTap,
    required this.onAboutTap,
    required this.onContactTap,
    required this.onMenuTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    // Sized up for the 1.5x center-crop zoom below, so the decode
    // target still matches the actual on-screen pixel footprint.
    final logoCacheSize = logoCacheDimension(context, 3000 * 1.5);

    return AppBar(
      backgroundColor: AppColors.navy,
      elevation: 4,
      toolbarHeight: 72,
      titleSpacing: 12,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.gold, width: 2),
            ),
            clipBehavior: Clip.antiAlias,
            child: Transform.scale(
              scale: 1,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                cacheWidth: logoCacheSize,
                cacheHeight: logoCacheSize,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Tsaphah Ministries',
                  style: TextStyle(
                    fontFamily: AppFonts.heading,
                    color: AppColors.goldLight,
                    fontSize: isDesktop ? 23 : 19,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (isDesktop)
                  const Text(
                    'CALLED TO WATCH, HEAR & PROCLAIM',
                    style: TextStyle(
                      color: AppColors.creamDark,
                      fontSize: 13,
                      letterSpacing: 1.5,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      actions: isDesktop
          ? [
              _NavButton(label: 'Home', onTap: onHomeTap),
              _NavButton(label: 'Ministries / Gallery', onTap: onGalleryTap),
              _NavButton(label: 'About', onTap: onAboutTap),
              _NavButton(label: 'Contact', onTap: onContactTap),
              const SizedBox(width: 12),
            ]
          : [
              IconButton(
                icon: const Icon(Icons.menu, color: AppColors.gold),
                onPressed: onMenuTap,
              ),
            ],
    );
  }
}

class _NavButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavButton({required this.label, required this.onTap});

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: TextButton(
        onPressed: widget.onTap,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.cream,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.label, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 3),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              height: 2,
              width: _hovering ? 18 : 0,
              color: AppColors.gold,
            ),
          ],
        ),
      ),
    );
  }
}

/// Drawer shown on mobile when the hamburger icon is tapped.
class SiteDrawer extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onGalleryTap;
  final VoidCallback onAboutTap;
  final VoidCallback onContactTap;

  const SiteDrawer({
    super.key,
    required this.onHomeTap,
    required this.onGalleryTap,
    required this.onAboutTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    // Sized up for the 1.5x center-crop zoom below, so the decode
    // target still matches the actual on-screen pixel footprint.
    final logoCacheSize = logoCacheDimension(context, 50 * 1.5);

    return Drawer(
      backgroundColor: AppColors.navySoft,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  ClipOval(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Transform.scale(
                        scale: 1.5,
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          gaplessPlayback: true,
                          cacheWidth: logoCacheSize,
                          cacheHeight: logoCacheSize,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Tsaphah Ministries',
                    style: TextStyle(
                      fontFamily: AppFonts.heading,
                      color: AppColors.goldLight,
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white24, height: 1),
            _DrawerItem(label: 'Home', onTap: onHomeTap),
            _DrawerItem(label: 'Ministries / Gallery', onTap: onGalleryTap),
            _DrawerItem(label: 'About', onTap: onAboutTap),
            _DrawerItem(label: 'Contact', onTap: onContactTap),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _DrawerItem({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label, style: const TextStyle(color: AppColors.cream)),
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
    );
  }
}

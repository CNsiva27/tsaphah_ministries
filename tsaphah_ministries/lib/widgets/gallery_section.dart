import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_fonts.dart';
import '../utils/responsive.dart';
import 'section_container.dart';

class GalleryItem {
  final String caption;
  final String imagePath;
  const GalleryItem(this.caption, this.imagePath);
}

const List<GalleryItem> galleryItems = [
  GalleryItem('Main Church – Konalai, Tiruchirappalli',
      'assets/images/church_hero.jpeg'),
  GalleryItem('On May 1, 2025, we inaugurated our church with Father Berhmans.',
      'assets/images/gallery/Berhmans.jpeg'),
  GalleryItem(
      'Sunday Worship Service', 'assets/images/gallery/worship_service.jpeg'),
  GalleryItem('Baptism Service', 'assets/images/gallery/baptism_service.jpeg'),
  GalleryItem("Worship team", 'assets/images/gallery/women_ministry.jpeg'),
  GalleryItem(
      'Yarcard Ministry', 'assets/images/gallery/Yercard_ministry.jpeg'),
  GalleryItem(
      'Abroad ministries', 'assets/images/gallery/German_ministries.jpeg'),
  GalleryItem('Community Service & Charity',
      'assets/images/gallery/community_outreach.jpeg'),
  GalleryItem(
      'Feeding the Poor', 'assets/images/gallery/Feeding_the_poor.jpeg'),
];

/// "Ministries / Gallery" section: a responsive grid of photo cards
/// for the ministry photos supplied so far.
class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.galleryColumns(context);

    return SectionContainer(
      backgroundColor: AppColors.creamDark.withValues(alpha: 0.88),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Ministries / Gallery',
            style: TextStyle(
              fontFamily: AppFonts.heading,
              color: AppColors.navy,
              fontSize: 29,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'A glimpse into worship, ministry, and church life across our congregations',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textMuted, fontSize: 17),
          ),
          const GoldRule(),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: galleryItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              final item = galleryItems[index];
              return _GalleryCard(
                  caption: item.caption, imagePath: item.imagePath);
            },
          ),
        ],
      ),
    );
  }
}

class _GalleryCard extends StatefulWidget {
  final String caption;
  final String imagePath;

  const _GalleryCard({required this.caption, required this.imagePath});

  @override
  State<_GalleryCard> createState() => _GalleryCardState();
}

class _GalleryCardState extends State<_GalleryCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        elevation: _hovering ? 8 : 3,
        shadowColor: Colors.black38,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRect(
                child: AnimatedScale(
                  scale: _hovering ? 1.15 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  child: Image.asset(widget.imagePath, fit: BoxFit.cover),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: const BoxDecoration(
                border:
                    Border(top: BorderSide(color: AppColors.gold, width: 3)),
              ),
              child: Text(
                widget.caption,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, color: AppColors.textDark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

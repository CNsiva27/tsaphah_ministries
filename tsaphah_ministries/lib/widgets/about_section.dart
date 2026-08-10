import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_fonts.dart';
import 'section_container.dart';

/// "About" section: the history of Tsaphah Prophetic Church with its
/// branches. The Vision and Pastor's calling content live in
/// [HeroSection], shown right after the Hero on the home page.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      backgroundColor: AppColors.cream.withValues(alpha: 0.88),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'About',
            style: TextStyle(
              fontFamily: AppFonts.heading,
              color: AppColors.navy,
              fontSize: 29,
              fontWeight: FontWeight.bold,
            ),
          ),
          const GoldRule(),
          const SizedBox(height: 8),
          const _BlockTitle('Tsaphah Prophetic Church'),
          const _BodyText(
            'Main Church – Konalai, Tiruchirappalli, Tamil Nadu',
            bold: true,
          ),
          const _BodyText(
            'Tsaphah Prophetic Church began its journey in 2017 in a small hut, '
            'with a simple beginning and a great vision from God. As the ministry '
            'grew, the church moved into a small shed-type building where believers '
            "gathered together in prayer, worship, and the teaching of God's Word.",
          ),
          const _BodyText(
            "Through the faithfulness of God and the prayers of His people, the "
            'ministry continued to grow. God graciously blessed Tsaphah Prophetic '
            'Church with a larger church building, providing a place where more '
            "people could gather to worship, hear God's Word, receive prayer, and "
            'experience His presence.',
          ),
          const _BodyText(
            "What began as a humble gathering in a hut has become a testimony of "
            "God's faithfulness, provision, and growth. The journey of Tsaphah "
            'Prophetic Church reminds us that when God gives the vision, He also '
            'provides the grace and strength to fulfil it.',
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Branch Churches',
              style: TextStyle(
                fontFamily: AppFonts.heading,
                color: AppColors.navy,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const _BranchCard(
            name: 'Tsaphah Prophetic Church – Yercaud',
            pastor: 'Pastor Karthick',
            description:
                'The Yercaud branch serves the local community through worship, '
                'prayer, preaching, and ministry, carrying forward the vision of '
                'Tsaphah Prophetic Church.',
          ),
          const SizedBox(height: 8),
          const _BranchCard(
            name: 'Tsaphah Prophetic Church – Islampur, West Bengal',
            pastor: 'Pastor Prasantho Das',
            description:
                'The Islampur branch extends the ministry into West Bengal, '
                'proclaiming the Gospel, strengthening believers, and serving the '
                'local community through prayer and the Word of God.',
          ),
          const SizedBox(height: 8),
          const _BodyText(
            'From a humble hut in 2017 to a growing ministry with churches in '
            'different places, Tsaphah Prophetic Church stands as a testimony '
            'that God can take a small beginning and use it for His greater purpose.',
          ),
        ],
      ),
    );
  }
}

class _BlockTitle extends StatelessWidget {
  final String text;
  const _BlockTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(bottom: 6),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.gold, width: 2)),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: AppFonts.heading,
            color: AppColors.navy,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _BodyText extends StatelessWidget {
  final String text;
  final bool bold;
  const _BodyText(this.text, {this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 17.5,
          height: 1.6,
          color: const Color(0xFF333333),
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

class _BranchCard extends StatelessWidget {
  final String name;
  final String pastor;
  final String description;

  const _BranchCard({
    required this.name,
    required this.pastor,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.creamDark,
        borderRadius: BorderRadius.circular(6),
        border: const Border(left: BorderSide(color: AppColors.gold, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,
              style: const TextStyle(
                  color: AppColors.navy,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          const SizedBox(height: 4),
          Text(pastor,
              style: const TextStyle(
                  color: Color(0xFF8A6D13),
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          const SizedBox(height: 8),
          Text(description,
              style: const TextStyle(
                  fontSize: 16.5, height: 1.5, color: Color(0xFF333333))),
        ],
      ),
    );
  }
}

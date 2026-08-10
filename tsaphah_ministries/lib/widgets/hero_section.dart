import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_fonts.dart';
import '../utils/responsive.dart';
import 'section_container.dart';

/// Home page hero: the "Tsaphah" verse over the shared church-photo
/// page background, blending into the ministry's vision and Pastor
/// Singh Selvaraj's calling. Shown directly below the banner.
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.navy.withValues(alpha: 0.88),
                AppColors.navySoft.withValues(alpha: 0.82),
              ],
            ),
          ),
          child: const Center(
            child: SectionContainer(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_HeroCardsSection()],
              ),
            ),
          ),
        ),
        SectionContainer(
          backgroundGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.cream.withValues(alpha: 0.97),
              AppColors.creamDark.withValues(alpha: 0.94),
            ],
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _BlockTitle('Pastor Singh Selvaraj – My Calling'),
              SizedBox(height: 10),
              _PastorBio(),
              SizedBox(height: 16),
              _BodyText(
                'Tsaphah Ministries — Called to Watch, Hear, and Proclaim.',
                bold: true,
                center: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroCardsSection extends StatelessWidget {
  const _HeroCardsSection();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    'צָפָה  •  Tsaphah',
                    style: TextStyle(color: AppColors.gold, fontSize: 21),
                  ),
                ),
                SizedBox(height: 10),
                _VerseCard(),
                SizedBox(height: 16),
                _MissionVisionCard(),
              ],
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: _ChurchActivitiesCard(),
          ),
        ),
      ],
    );
  }
}

class _VerseCard extends StatelessWidget {
  const _VerseCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"Son of man, I have made you a watchman for the house of Israel; '
            'therefore hear a word from My mouth, and give them warning from Me."',
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontSize: 18,
              height: 1.5,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '— Ezekiel 3:17 (NKJV)',
            style: TextStyle(color: AppColors.goldLight, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _BlockTitle extends StatelessWidget {
  final String text;
  final bool light;
  const _BlockTitle(this.text, {this.light = false});

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
            color: light ? AppColors.goldLight : AppColors.navy,
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
  final bool light;
  final bool center;
  const _BodyText(
    this.text, {
    this.bold = false,
    this.light = false,
    this.center = false,
  });

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      textAlign: center ? TextAlign.center : TextAlign.left,
      style: TextStyle(
        fontSize: 17.5,
        height: 1.6,
        color: light ? const Color(0xFFEFE7CE) : const Color(0xFF333333),
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: center
          ? textWidget
          : Align(alignment: Alignment.centerLeft, child: textWidget),
    );
  }
}

class _MissionVisionCard extends StatelessWidget {
  const _MissionVisionCard();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BlockTitle('Our Mission', light: true),
        _BodyText(
          '    To reach the people of God through love and sharing '
          'spiritually and materially.',
          light: true,
        ),
        SizedBox(height: 16),
        _BlockTitle('Our Vision', light: true),
        _BodyText(
          '    To harvest people of God to the Kingdom of Jesus Christ.',
          light: true,
        ),
      ],
    );
  }
}

class _ChurchActivitiesCard extends StatelessWidget {
  const _ChurchActivitiesCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 900),
      padding: const EdgeInsets.all(20),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BlockTitle('Church Activities', light: true),
          SizedBox(height: 8),
          _BodyText(
            '1. Every Sunday 9 AM (Communion Service)',
            bold: true,
            light: true,
          ),
          _BodyText(
            '2. Every second Saturday — Fasting and Prayer 10 AM',
            bold: true,
            light: true,
          ),
          _BodyText(
            '3. Every month 1st day — Dawn Prayer morning 7 AM '
            'with Holy Communion',
            bold: true,
            light: true,
          ),
        ],
      ),
    );
  }
}

class _PastorBio extends StatelessWidget {
  const _PastorBio();

  static const String _bio1 =
      'Pastor Singh Selvaraj is called to serve God as a watchman and servant '
      'of His people. His calling is rooted in Ezekiel 3:17, where God says, '
      '"I have made you a watchman for the house of Israel." The name Tsaphah '
      'means to watch, remain alert, guard, and listen carefully.';
  static const String _bio2 =
      'Through Tsaphah Ministries, he desires to faithfully hear the voice of '
      'God and proclaim His Word. His heart is to lead people closer to Jesus '
      'Christ and strengthen the Church. He is committed to preaching the '
      'Gospel with faith, courage, and obedience.';
  static const String _bio3 =
      'His ministry seeks to encourage the broken, strengthen the weak, and '
      'call people toward repentance and holiness. As a spiritual watchman, he '
      "desires to pray, discern, warn, guide, and encourage God's people. His "
      'greatest desire is to remain faithful to the assignment God has '
      'entrusted to him — to watch, hear, and proclaim what God places in his '
      'heart.';

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final photo = ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gold, width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        width: 220,
        child: Image.asset('assets/images/pastor.jpeg', fit: BoxFit.cover),
      ),
    );

    const bio = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BodyText(_bio1),
        _BodyText(_bio2),
        _BodyText(_bio3),
      ],
    );

    if (isMobile) {
      return Column(
        children: [
          Center(child: photo),
          const SizedBox(height: 14),
          bio,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        photo,
        const SizedBox(width: 32),
        const Expanded(child: bio),
      ],
    );
  }
}

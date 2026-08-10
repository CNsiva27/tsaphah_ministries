import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../theme/app_fonts.dart';
import '../utils/responsive.dart';
import 'map_preview.dart';
import 'section_container.dart';

const _kVerticalPadding = 40.0;
const _churchAddress =
    'Tsaphah Prophetic Church, Konalai, Tiruchirappalli, Tamil Nadu, India';
const _churchCoordinates = '10.98435936857708, 78.76674072695872';
// Google Maps' "lat,lng(Label)" query format pins the exact coordinates
// while showing the church name instead of raw numbers when opened.
const _churchMapQuery = '$_churchCoordinates(Tsaphah Prophetic Church)';

/// Contact Us section: address, phone/WhatsApp, email, and social
/// media icons, followed by the site footer (copyright + tagline) in
/// the same navy panel. Placeholder values are marked clearly —
/// update them with the ministry's real details before publishing.
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildContactItems(bool isMobile) {
    final addressInfo = _ContactItem(
      icon: const Icon(Icons.location_on_outlined),
      title: 'Main Church Address',
      subtitle:
          'Tsaphah Prophetic Church\nKonalai, Tiruchirappalli,\nTamil Nadu, India',
      centerIcon: true,
      iconFlex: 1,
      contentFlex: 3,
      onTap: () => _launch(
          'https://maps.google.com/?q=${Uri.encodeComponent(_churchAddress)}'),
    );

    final mapBox = ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gold, width: 2),
        ),
        child: const MapPreview(query: _churchMapQuery),
      ),
    );

    final addressCard = _ContactCard(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          addressInfo,
          const SizedBox(height: 14),
          mapBox,
        ],
      ),
    );

    final phoneCard = _ContactCard(
      alignment: Alignment.centerLeft,
      child: _ContactItem(
        icon: const Icon(Icons.phone_outlined),
        title: 'Mobile',
        subtitle: '+91 72000 90986',
        onTap: () => _launch('tel:+917200090986'),
      ),
    );

    final emailCard = _ContactCard(
      alignment: Alignment.centerLeft,
      child: _ContactItem(
        icon: const Icon(Icons.email_outlined),
        title: 'Email',
        subtitle: 'pastorsinghselvaraj@gmail.com',
        onTap: () => _launch('mailto:pastorsinghselvaraj@gmail.com'),
      ),
    );

    final phoneEmailGroup = Column(
      children: isMobile
          ? [
              phoneCard,
              const SizedBox(height: 20),
              emailCard,
            ]
          : [
              Expanded(child: phoneCard),
              const SizedBox(
                height: 20,
              ),
              Expanded(child: emailCard),
            ],
    );

    final offeringCard = _ContactCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                    color: AppColors.gold, shape: BoxShape.circle),
                child: const Icon(Icons.volunteer_activism_outlined,
                    color: AppColors.navy, size: 20),
              ),
              const SizedBox(width: 10),
              const Text(
                'Offering to the church',
                style: TextStyle(
                    color: AppColors.goldLight,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Scan to give',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFFD9D2BC), fontSize: 13.5),
          ),
          const SizedBox(height: 12),
          Container(
            width: 180,
            height: 180,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.gold, width: 2),
            ),
            child: Image.asset(
              'assets/images/Offering_QRCode.jpeg',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );

    final cards = [offeringCard, addressCard, phoneEmailGroup];

    if (isMobile) {
      return Column(
        children: [
          for (var i = 0; i < cards.length; i++) ...[
            if (i > 0) const SizedBox(height: 20),
            cards[i],
          ],
        ],
      );
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < cards.length; i++) ...[
            Expanded(child: cards[i]),
            if (i < cards.length - 1) const SizedBox(width: 20),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return SectionContainer(
      backgroundColor: AppColors.navy.withValues(alpha: 0.82),
      verticalPadding: EdgeInsets.symmetric(
        vertical: _kVerticalPadding,
        horizontal: isMobile ? 20 : 24,
      ),
      child: Column(
        children: [
          Text(
            'Contact Us',
            style: TextStyle(
              fontFamily: AppFonts.heading,
              color: AppColors.goldLight,
              fontSize: 29,
              fontWeight: FontWeight.bold,
            ),
          ),
          const GoldRule(),
          const SizedBox(height: 8),
          _buildContactItems(isMobile),
          const SizedBox(height: 16),
          const Text(
            'Follow Us',
            style: TextStyle(
                color: AppColors.goldLight,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            children: [
              _SocialIcon(
                  icon: FontAwesomeIcons.youtube,
                  onTap: () => _launch('https://www.youtube.com/@singhicem')),
              _SocialIcon(
                  icon: FontAwesomeIcons.whatsapp,
                  onTap: () => _launch('https://wa.me/918248469216')),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.white12, width: 1)),
            ),
            child: Column(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(color: Color(0xFF8C93A3), fontSize: 15.5),
                    children: [
                      TextSpan(text: '© 2026 '),
                      TextSpan(
                          text: 'Tsaphah Ministries',
                          style: TextStyle(color: AppColors.gold)),
                      TextSpan(text: '. All Rights Reserved.'),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Called to Watch, Hear, and Proclaim — Ezekiel 3:17',
                  style: TextStyle(color: Color(0xFF8C93A3), fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Shared bordered/tinted card used for each of the three contact
/// groups (address, phone+email, offering) so they read as distinct
/// panels rather than loose floating content.
class _ContactCard extends StatelessWidget {
  final Widget child;
  final Alignment alignment;
  const _ContactCard({required this.child, this.alignment = Alignment.center});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Align(alignment: alignment, child: child),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool centerIcon;

  /// When both are set, the icon and text columns split the row's full
  /// width by this flex ratio instead of the icon using a fixed 40px
  /// and the row capping at 260px total.
  final int? iconFlex;
  final int? contentFlex;

  const _ContactItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.centerIcon = true,
    this.iconFlex,
    this.contentFlex,
  });

  @override
  Widget build(BuildContext context) {
    final iconContainer = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 40,
        height: 40,
        decoration:
            const BoxDecoration(color: AppColors.gold, shape: BoxShape.circle),
        padding: const EdgeInsets.all(8),
        child: icon,
      ),
    );

    final textColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title,
            style: const TextStyle(
                color: AppColors.goldLight,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
              color: Color(0xFFD9D2BC), fontSize: 15, height: 1.4),
        ),
      ],
    );

    final crossAxisAlignment =
        centerIcon ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    final row = iconFlex != null && contentFlex != null
        ? Row(
            crossAxisAlignment: crossAxisAlignment,
            children: [
              Expanded(
                flex: iconFlex!,
                child: Align(alignment: Alignment.center, child: iconContainer),
              ),
              Expanded(flex: contentFlex!, child: textColumn),
            ],
          )
        : ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: crossAxisAlignment,
              children: [
                iconContainer,
                const SizedBox(width: 20),
                Flexible(child: textColumn),
              ],
            ),
          );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: row,
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialIcon({required this.icon, required this.onTap});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: InkWell(
        onTap: widget.onTap,
        customBorder: const CircleBorder(),
        child: AnimatedScale(
          scale: _hovering ? 1.15 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _hovering ? AppColors.gold.withValues(alpha: 0.15) : null,
              border: const Border.fromBorderSide(
                  BorderSide(color: AppColors.gold, width: 2)),
            ),
            child: Icon(widget.icon, color: AppColors.goldLight, size: 20),
          ),
        ),
      ),
    );
  }
}

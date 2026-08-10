import 'package:google_fonts/google_fonts.dart';

/// Font families matching the Tsaphah Ministries logo: a classic
/// engraved-serif for headings ("TSAPHAH") and a clean sans-serif
/// for body copy.
class AppFonts {
  AppFonts._();

  static String get heading => GoogleFonts.cinzel().fontFamily!;
  static String get body => GoogleFonts.lato().fontFamily!;
}

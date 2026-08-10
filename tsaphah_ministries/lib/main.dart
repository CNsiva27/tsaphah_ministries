import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'theme/app_fonts.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const TsaphahMinistriesApp());
}

class TsaphahMinistriesApp extends StatelessWidget {
  const TsaphahMinistriesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tsaphah Ministries',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: AppFonts.body,
        scaffoldBackgroundColor: AppColors.cream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.gold,
          primary: AppColors.gold,
          secondary: AppColors.navy,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.navy,
          foregroundColor: AppColors.cream,
        ),
      ),
      home: const HomePage(),
    );
  }
}

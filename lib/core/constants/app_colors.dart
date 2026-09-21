import 'package:flutter/material.dart';

/// Easypaisa Brand Colors & Gradient Definitions
class AppColors {
  AppColors._();

  // Primary Easypaisa Greens
  static const Color primaryGreen = Color(0xFF00A859);
  static const Color primaryDarkGreen = Color(0xFF006747);
  static const Color cardDarkGreen = Color(0xFF00563B);
  static const Color accentBrightGreen = Color(0xFF00D75A);
  static const Color lightMintGreen = Color(0xFFD6F5E3);
  static const Color softGreenBg = Color(0xFFF2FBF6);

  // Backgrounds
  static const Color scaffoldBackground = Color(0xFFF4F4F6);
  static const Color cardWhite = Colors.white;
  static const Color charcoalIcon = Color(0xFF262D35);

  // App Bar Green-Yellow-Green Gradient (Matching Official UI)
  static const LinearGradient appBarGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF72E0A4),
      Color(0xFFB8F0AD),
      Color(0xFFFFF4A3),
      Color(0xFFB8F0AD),
      Color(0xFF72E0A4),
    ],
    stops: [0.0, 0.28, 0.50, 0.72, 1.0],
  );

  // Top Header Vertical Blend Gradient (Fading into #F4F4F6 background)
  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF86E8B1),
      Color(0xFFCEF6DF),
      Color(0xFFE8F6EE),
      Color(0xFFF4F4F6),
    ],
    stops: [0.0, 0.40, 0.80, 1.0],
  );

  // Account Card Gradient
  static const LinearGradient accountCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF006B4B),
      Color(0xFF004D36),
    ],
  );

  // Card Borders & Outlines
  static const Color cardBorder = Color(0xFFEFF2F3);
  static const Color dividerColor = Color(0xFFE5E9EB);
  static const Color inactiveDot = Color(0xFFD8DFE2);

  // Text Colors
  static const Color textPrimary = Color(0xFF191C1E);
  static const Color textSecondary = Color(0xFF5F6E76);
  static const Color textLight = Color(0xFF90A1A8);
  static const Color textWhite = Colors.white;
  static const Color textGold = Color(0xFFE8C88A);

  // Debit Cards Colors
  static const Color onlineCardBg = Color(0xFF1A5643);
  static const Color plasticCardBg = Color(0xFF2B2D38);
  static const Color chipGold = Color(0xFFD4AF37);
  static const Color chipGoldAccent = Color(0xFFF3E5AB);

  // Mini-App Badge Colors
  static const Color badgeGreen = Color(0xFF00A859);
  static const Color badgeOrange = Color(0xFFFF7A00);
  static const Color badgePurple = Color(0xFF7B1FA2);
  static const Color badgeTeal = Color(0xFF00838F);

  // Mascot Yellow
  static const Color mascotYellow = Color(0xFFFFD500);
  static const Color mascotOrange = Color(0xFFFF9E00);

  // Shadow Colors
  static const Color softShadow = Color(0x0A000000);
  static const Color mediumShadow = Color(0x14000000);
  static const Color qrButtonGlow = Color(0x5500A859);
}

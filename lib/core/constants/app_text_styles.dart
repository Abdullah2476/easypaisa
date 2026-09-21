import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Headings
  static TextStyle sectionTitle = GoogleFonts.outfit(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
  );

  static TextStyle cardTitle = GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle cardTitleWhite = GoogleFonts.outfit(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: AppColors.textWhite,
  );

  // Subtitles & Body
  static TextStyle bodyMedium = GoogleFonts.outfit(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  static TextStyle bodySmall = GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle bodySmallBold = GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Grid Labels
  static TextStyle gridItemLabel = GoogleFonts.outfit(
    fontSize: 12.5,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  // Buttons
  static TextStyle buttonText = GoogleFonts.outfit(
    fontSize: 13.5,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle buttonTextGreen = GoogleFonts.outfit(
    fontSize: 13.5,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryGreen,
  );

  static TextStyle buttonTextWhite = GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textWhite,
  );

  // Badges
  static TextStyle badgeText = GoogleFonts.outfit(
    fontSize: 9.5,
    fontWeight: FontWeight.w700,
    color: AppColors.textWhite,
    letterSpacing: 0.2,
  );

  // Navigation
  static TextStyle navLabel = GoogleFonts.outfit(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle navLabelActive = GoogleFonts.outfit(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryGreen,
  );
}

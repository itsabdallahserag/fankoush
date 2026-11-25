import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// Centralized Typography system for Fankoush application.
/// Named systematically as [weight][fontSize][ColorName] (e.g. bold16White).
class AppTextStyles {
  AppTextStyles._();

  // ====================================================
  // --- Figma Specific Styles [weight][size][HEX] ---
  // ====================================================
  static final TextStyle semibold16FD5C53 = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: const Color(0xFFFD5C53),
  );
  static final TextStyle semiBold16FD5C53 = semibold16FD5C53;

  static final TextStyle extrabold311B2230 = GoogleFonts.cairo(
    fontSize: 31,
    fontWeight: FontWeight.w800,
    color: const Color(0xFF1B2230),
  );
  static final TextStyle extraBold311B2230 = extrabold311B2230;

  static final TextStyle semibold15666C7B = GoogleFonts.cairo(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF666C7B),
  );
  static final TextStyle semiBold15666C7B = semibold15666C7B;

  static final TextStyle bold18000000 = GoogleFonts.cairo(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF000000),
  );

  static final TextStyle bold171B1C1C = GoogleFonts.cairo(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF1B1C1C),
  );

  static final TextStyle regular164E4633 = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF4E4633),
  );

  static final TextStyle medium11807660 = GoogleFonts.cairo(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF807660),
  );

  static final TextStyle semibold141B1C1C = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF1B1C1C),
  );

  static final TextStyle medium11White = GoogleFonts.cairo(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static final TextStyle regular12807660WithOpacity80 = GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF807660).withOpacity(0.8),
  );

  // ==========================================
  // --- ExtraBold / Display Styles (w800) ---
  // ==========================================
  static final TextStyle extraBold32TextPrimary = GoogleFonts.cairo(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static final TextStyle extraBold28TextPrimary = GoogleFonts.cairo(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static final TextStyle extraBold26TextPrimary = GoogleFonts.cairo(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static final TextStyle extraBold24TextPrimary = GoogleFonts.cairo(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  // ==========================================
  // --- Bold Styles (w700) ---
  // ==========================================
  static final TextStyle bold24TextPrimary = GoogleFonts.cairo(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static final TextStyle bold22TextPrimary = GoogleFonts.cairo(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static final TextStyle bold20TextPrimary = GoogleFonts.cairo(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static final TextStyle bold20Primary = GoogleFonts.cairo(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static final TextStyle bold20Secondary = GoogleFonts.cairo(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.secondary,
  );

  static final TextStyle bold18TextPrimary = GoogleFonts.cairo(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static final TextStyle bold16White = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textWhite,
  );

  static final TextStyle bold16TextPrimary = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static final TextStyle bold16Primary = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static final TextStyle bold16Secondary = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.secondary,
  );

  static final TextStyle bold14TextPrimary = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static final TextStyle bold14White = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textWhite,
  );

  static final TextStyle bold12TextPrimary = GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // ==========================================
  // --- SemiBold Styles (w600) ---
  // ==========================================
  static final TextStyle semiBold20TextPrimary = GoogleFonts.cairo(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static final TextStyle semiBold18TextPrimary = GoogleFonts.cairo(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static final TextStyle semiBold16TextPrimary = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static final TextStyle semiBold16White = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite,
  );

  static final TextStyle semiBold16Secondary = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.secondary,
  );

  static final TextStyle semiBold14TextPrimary = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static final TextStyle semiBold14TextSecondary = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static final TextStyle semiBold12TextPrimary = GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // ==========================================
  // --- Medium Styles (w500) ---
  // ==========================================
  static final TextStyle medium16TextPrimary = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static final TextStyle medium16TextSecondary = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static final TextStyle medium15TextPrimary = GoogleFonts.cairo(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static final TextStyle medium14TextPrimary = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static final TextStyle medium14TextSecondary = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static final TextStyle medium14White = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textWhite,
  );

  static final TextStyle medium12TextPrimary = GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static final TextStyle medium12TextSecondary = GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static final TextStyle medium12Primary = GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );

  static final TextStyle medium10TextSecondary = GoogleFonts.cairo(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  // ==========================================
  // --- Regular Styles (w400) ---
  // ==========================================
  static final TextStyle regular16TextPrimary = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static final TextStyle regular16TextSecondary = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static final TextStyle regular14TextPrimary = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static final TextStyle regular14TextSecondary = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static final TextStyle regular14TextMuted = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );

  static final TextStyle regular12TextSecondary = GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static final TextStyle regular12TextPrimary = GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static final TextStyle regular10TextSecondary = GoogleFonts.cairo(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // ====================================================
  // --- Semantic Aliases (Preserving Theme Compatibility) ---
  // ====================================================
  static TextStyle get displayLarge => extraBold28TextPrimary;
  static TextStyle get displayMedium => extraBold24TextPrimary;
  static TextStyle get headingLarge => bold22TextPrimary;
  static TextStyle get headingMedium => bold20TextPrimary;
  static TextStyle get headingSmall => semiBold18TextPrimary;
  static TextStyle get titleLarge => semiBold18TextPrimary;
  static TextStyle get titleMedium => semiBold16TextPrimary;
  static TextStyle get titleSmall => medium15TextPrimary;
  static TextStyle get bodyLarge => regular16TextPrimary;
  static TextStyle get bodyMedium => regular14TextPrimary;
  static TextStyle get bodySmall => regular12TextSecondary;
  static TextStyle get labelLarge => bold16TextPrimary;
  static TextStyle get labelMedium => semiBold14TextPrimary;
  static TextStyle get labelSmall => medium10TextSecondary;
}

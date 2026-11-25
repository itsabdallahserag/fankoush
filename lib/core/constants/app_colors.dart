import 'package:flutter/material.dart';

/// Centralized color palette for Fankoush application.
/// Extracted directly from Figma design tokens, styles, and vector layers.
class AppColors {
  AppColors._();

  // ==========================================
  // Brand & Primary Colors (Yellows & Ambers)
  // ==========================================
  /// Main vibrant brand yellow (Fankoush Popcorn yellow)
  static const Color primary = Color(0xFFFEC529);

  /// Darker yellow tone for press states and emphasis
  static const Color primaryDark = Color(0xFFE5B025);

  /// Soft pastel yellow for subtle card badges and highlights
  static const Color primaryLight = Color(0xFFFFF2D0);

  /// Warm energetic golden orange accent (Mic button halo, badges)
  static const Color primaryOrange = Color(0xFFF5A623);

  /// Soft pale yellow fill for attempts counter badge
  static const Color softYellow = Color(0xFFFFF3C4);

  /// Subtle gold border for attempts chip and audio upload pill
  static const Color softGoldBorder = Color(0xFFFFE082);

  /// Light warm amber tint
  static const Color lightAmber = Color(0xFFFFF8E1);

  // ==========================================
  // Secondary & Interactive Colors (Blues)
  // ==========================================
  /// Interactive CTA blue (Active indicators, prominent buttons, links)
  static const Color secondary = Color(0xFF399CFE);

  /// Secondary blue tone variant
  static const Color secondaryAlt = Color(0xFF3B9BFF);

  /// Light blue surface background (Active radio/selection container)
  static const Color secondaryLight = Color(0xFFEBF5FF);

  /// Active audio waveform bar color
  static const Color audioWaveActive = Color(0xFF399CFE);

  /// Inactive audio waveform bar color
  static const Color audioWaveInactive = Color(0xFFD4E7FA);

  /// Active dot / slider indicator color
  static const Color indicatorActive = Color(0xFF399CFE);

  /// Inactive dot / slider indicator color
  static const Color indicatorInactive = Color(0xFFD9DCDF);

  /// Direct color hex aliases for design fidelity
  static const Color c399CFE = Color(0xFF399CFE);
  static const Color cD9DCDF = Color(0xFFD9DCDF);

  // ==========================================
  // Backgrounds & Surfaces
  // ==========================================
  /// Warm friendly cream canvas background (Figma Artboard fill)
  static const Color background = Color(0xFFFDFBF4);

  /// Card and container pure white surface
  static const Color surface = Color(0xFFFFFFFF);

  /// Subtle warm card surface
  static const Color surfaceWarm = Color(0xFFFFFDF9);

  /// Light neutral gray surface
  static const Color surfaceGray = Color(0xFFF1F2F4);

  /// Alternative neutral gray background
  static const Color surfaceGrayAlt = Color(0xFFEDEEF1);

  /// Input field background fill
  static const Color inputBackground = Color(0xFFF7F5EE);

  /// Bottom navigation bar surface
  static const Color navBackground = Color(0xFFFFFFFF);

  // ==========================================
  // Typography & Text Colors
  // ==========================================
  /// Primary dark text for headings and high emphasis
  static const Color textPrimary = Color(0xFF150E16);

  /// Deep navy charcoal for prominent top bar icons and headings
  static const Color textHeadingDark = Color(0xFF1B2230);

  /// Pure dark charcoal / near black
  static const Color textPureBlack = Color(0xFF1A1A1A);

  /// Subtle slate neutral gray text
  static const Color textSubtle = Color(0xFF666C7B);

  /// Secondary neutral gray text for subtitles, captions, and inactive tabs
  static const Color textSecondary = Color(0xFF928E89);

  /// Muted / placeholder / disabled text
  static const Color textMuted = Color(0xFFB5B2AC);

  /// Pure white text for buttons with dark/colored backgrounds
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color primaryborder = Color(0xFFFCD66C);

  // ==========================================
  // Borders & Dividers
  // ==========================================
  /// Subtle divider and card border
  static const Color border = Color(0xFFEAE7DF);
  static const Color c3C3C3C = Color(0xFF3C3C3C);

  /// Soft warm border
  static const Color borderLight = Color(0xFFF2EFEB);

  /// Medium card outline border
  static const Color borderMedium = Color(0xFFD9D6CE);

  /// Neutral border gray
  static const Color borderGray = Color(0xFFD9DCDF);

  /// Neutral border standard
  static const Color borderNeutral = Color(0xFFD9D9D9);

  /// Divider line border
  static const Color borderDivider = Color(0xFFE5E7EB);

  // ==========================================
  // Feedback & State Colors
  // ==========================================
  /// Error / Destructive coral red (Delete, stop audio, validation)
  static const Color error = Color(0xFFFD5C53);

  /// 15% opacity coral red for destructive badges
  static const Color errorBackground = Color(0x26FD5C53);

  /// Error alternative coral red
  static const Color errorAlt = Color(0xFFEF6461);

  /// Soft coral red highlight
  static const Color errorLight = Color(0xFFFF6B5E);

  /// Success mint green (Active subscription, checks)
  static const Color success = Color(0xFF2ECC71);

  /// 15% opacity mint green for success badges
  static const Color successBackground = Color(0x262ECC71);

  // ==========================================
  // Component Specific & Navigation Colors
  // ==========================================
  /// Inactive bottom navigation item color
  static const Color navInactive = Color(0xFF928E89);

  /// Active blue bottom navigation tab color
  static const Color navActive = Color(0xFF399CFE);

  /// Active yellow bottom navigation pill background
  static const Color navActiveYellow = Color(0xFFFEC529);

  // ==========================================
  // Shadows & Overlays
  // ==========================================
  /// Light card elevation shadow
  static const Color shadowLight = Color(0x14000000);

  /// Medium elevation shadow
  static const Color shadowMedium = Color(0x1A000000);
}

import 'package:flutter/material.dart';

import '../../features/home/domain/models/memory_item_model.dart';

/// Raw palette + Material 3 [ColorScheme]s for "Serene Trust".
///
/// Rule of thumb: widgets should read colors from `Theme.of(context)`
/// (`colorScheme`) or `context.appColors` — never from this class directly.
/// The raw constants exist so the theme layer has one source of truth.
abstract final class AppColors {
  // ── Brand ────────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF1D4E5B); // Deep Slate Teal
  static const Color secondary = Color(0xFFB45309); // Royal Bronze Amber
  static const Color tertiary = Color(0xFF476355); // Olive Slate

  // ── Light neutrals ───────────────────────────────────────────────────────
  static const Color canvas = Color(0xFFF4F3EF); // Warm Linen / Parchment
  static const Color card = Color(0xFFFFFFFF);
  static const Color fieldFill = Color(0xFFFBFBFA);
  static const Color border = Color(0xFFE5E5DF);
  static const Color onSurface = Color(0xFF1B1C1A);
  static const Color onSurfaceVariant = Color(0xFF40484B);
  static const Color outline = Color(0xFF71787B);

  // ── Dark neutrals ────────────────────────────────────────────────────────
  static const Color darkBg = Color(0xFF0F172A); // Deep Obsidian
  static const Color darkSurface = Color(0xFF1E293B); // cards
  static const Color darkOverlay = Color(0xFF334155); // dialogs / sheets
  static const Color darkBorder = Color(0xFF334155);

  /// Modal scrim: rgba(15, 23, 42, 0.45)
  static const Color scrim = Color(0x730F172A);

  // ── Material 3 color schemes ─────────────────────────────────────────────
  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFBBEAFA),
    onPrimaryContainer: Color(0xFF001F27),
    secondary: secondary,
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFFFDBCA),
    onSecondaryContainer: Color(0xFF331200),
    tertiary: tertiary,
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFCAEAD8),
    onTertiaryContainer: Color(0xFF042015),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF93000A),
    surface: canvas,
    onSurface: onSurface,
    onSurfaceVariant: onSurfaceVariant,
    surfaceDim: Color(0xFFDBDAD6),
    surfaceBright: canvas,
    surfaceContainerLowest: card,
    surfaceContainerLow: fieldFill,
    surfaceContainer: Color(0xFFEFEEEA),
    surfaceContainerHigh: Color(0xFFE9E8E4),
    surfaceContainerHighest: Color(0xFFE3E2DF),
    outline: outline,
    outlineVariant: border,
    shadow: primary,
    scrim: Color(0xFF0F172A),
    inverseSurface: Color(0xFF30312E),
    onInverseSurface: Color(0xFFF2F1ED),
    inversePrimary: Color(0xFF9FCEDD),
    surfaceTint: Colors.transparent, // no M3 tint overlay on elevation
  );

  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF2DD4BF),
    onPrimary: Color(0xFF04222A),
    primaryContainer: primary,
    onPrimaryContainer: Color(0xFFBBEAFA),
    secondary: Color(0xFFFDBA74),
    onSecondary: Color(0xFF331200),
    secondaryContainer: Color(0xFF763300),
    onSecondaryContainer: Color(0xFFFFDBCA),
    tertiary: Color(0xFFAFCEBC),
    onTertiary: Color(0xFF042015),
    tertiaryContainer: Color(0xFF314C3F),
    onTertiaryContainer: Color(0xFFCAEAD8),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: darkBg,
    onSurface: Color(0xFFE2E8F0),
    onSurfaceVariant: Color(0xFFAAB8CC),
    surfaceDim: Color(0xFF0B1120),
    surfaceBright: Color(0xFF283548),
    surfaceContainerLowest: Color(0xFF0B1120),
    surfaceContainerLow: Color(0xFF172033),
    surfaceContainer: darkSurface,
    surfaceContainerHigh: Color(0xFF2A3647),
    surfaceContainerHighest: darkOverlay,
    outline: Color(0xFF7C8A9E),
    outlineVariant: darkBorder,
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFFE2E8F0),
    onInverseSurface: darkBg,
    inversePrimary: primary,
    surfaceTint: Colors.transparent,
  );
}

/// Colors for one memory category.
///
/// * [base]   – saturated color: dots, icons, selected-chip fill (white text).
/// * [tint]   – 12 % (light) / 20 % (dark) container background.
/// * [onTint] – text/icon color that stays AA-readable on top of [tint].
@immutable
class AppCategoryColors {
  const AppCategoryColors({
    required this.base,
    required this.tint,
    required this.onTint,
  });

  final Color base;
  final Color tint;
  final Color onTint;
}

/// Status colors (success / warning / info / danger).
///
/// * [main]        – icons, fills, borders (not guaranteed AA as small text).
/// * [text]        – AA-safe color for text on the page background.
/// * [container]   – soft banner / snackbar background.
/// * [onContainer] – text on [container].
@immutable
class AppStatusColors {
  const AppStatusColors({
    required this.main,
    required this.text,
    required this.container,
    required this.onContainer,
  });

  final Color main;
  final Color text;
  final Color container;
  final Color onContainer;
}

/// App-specific tokens that Material's [ColorScheme] has no slot for.
/// Access with `context.appColors`.
@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.success,
    required this.warning,
    required this.info,
    required this.danger,
    required this.medical,
    required this.financial,
    required this.family,
    required this.friends,
    required this.personal,
    required this.other,
    required this.overlaySurface,
    required this.voiceProcessingTrack,
  });

  final AppStatusColors success;
  final AppStatusColors warning;
  final AppStatusColors info;

  /// Voice "no match" / destructive emphasis (#DC2626 family).
  final AppStatusColors danger;

  final AppCategoryColors medical;
  final AppCategoryColors financial;
  final AppCategoryColors family;
  final AppCategoryColors friends;
  final AppCategoryColors personal;
  final AppCategoryColors other;

  /// Dialogs and bottom sheets.
  final Color overlaySurface;

  /// Amber track that rotates around the mic button while processing.
  final Color voiceProcessingTrack;

  AppCategoryColors category(MemoryCategory c) {
    switch (c) {
      case MemoryCategory.medical:
        return medical;
      case MemoryCategory.financial:
        return financial;
      case MemoryCategory.family:
        return family;
      case MemoryCategory.friends:
        return friends;
      case MemoryCategory.personal:
        return personal;
      case MemoryCategory.other:
        return other;
    }
  }

  static const AppSemanticColors light = AppSemanticColors(
    success: AppStatusColors(
      main: Color(0xFF15803D),
      text: Color(0xFF15803D),
      container: Color(0xFFDCFCE7),
      onContainer: Color(0xFF14532D),
    ),
    warning: AppStatusColors(
      main: Color(0xFFD97706),
      text: Color(0xFF92400E),
      container: Color(0xFFFEF3C7),
      onContainer: Color(0xFF78350F),
    ),
    info: AppStatusColors(
      main: Color(0xFF0284C7),
      text: Color(0xFF0369A1),
      container: Color(0xFFE0F2FE),
      onContainer: Color(0xFF0C4A6E),
    ),
    danger: AppStatusColors(
      main: Color(0xFFDC2626),
      text: Color(0xFFB91C1C),
      container: Color(0xFFFEE2E2),
      onContainer: Color(0xFF7F1D1D),
    ),
    // tint = category base @ 12 % (0x1F)
    medical: AppCategoryColors(
      base: Color(0xFF0D9488),
      tint: Color(0x1F0D9488),
      onTint: Color(0xFF0F766E),
    ),
    financial: AppCategoryColors(
      base: Color(0xFFB45309),
      tint: Color(0x1FB45309),
      onTint: Color(0xFF92400E),
    ),
    family: AppCategoryColors(
      base: Color(0xFFC2410C),
      tint: Color(0x1FC2410C),
      onTint: Color(0xFF9A3412),
    ),
    friends: AppCategoryColors(
      base: Color(0xFF4F46E5),
      tint: Color(0x1F4F46E5),
      onTint: Color(0xFF4F46E5),
    ),
    personal: AppCategoryColors(
      base: Color(0xFF7C3AED),
      tint: Color(0x1F7C3AED),
      onTint: Color(0xFF7C3AED),
    ),
    other: AppCategoryColors(
      base: Color(0xFF64748B),
      tint: Color(0x1F64748B),
      onTint: Color(0xFF475569),
    ),
    overlaySurface: AppColors.card,
    voiceProcessingTrack: Color(0xFFF59E0B),
  );

  static const AppSemanticColors dark = AppSemanticColors(
    success: AppStatusColors(
      main: Color(0xFF4ADE80),
      text: Color(0xFF4ADE80),
      container: Color(0xFF0F3320),
      onContainer: Color(0xFFBBF7D0),
    ),
    warning: AppStatusColors(
      main: Color(0xFFFBBF24),
      text: Color(0xFFFCD34D),
      container: Color(0xFF3A2A08),
      onContainer: Color(0xFFFDE68A),
    ),
    info: AppStatusColors(
      main: Color(0xFF38BDF8),
      text: Color(0xFF7DD3FC),
      container: Color(0xFF0C2D44),
      onContainer: Color(0xFFBAE6FD),
    ),
    danger: AppStatusColors(
      main: Color(0xFFF87171),
      text: Color(0xFFFCA5A5),
      container: Color(0xFF3F1414),
      onContainer: Color(0xFFFECACA),
    ),
    // tint = category base @ 20 % (0x33)
    medical: AppCategoryColors(
      base: Color(0xFF2DD4BF),
      tint: Color(0x332DD4BF),
      onTint: Color(0xFF5EEAD4),
    ),
    financial: AppCategoryColors(
      base: Color(0xFFFBBF24),
      tint: Color(0x33FBBF24),
      onTint: Color(0xFFFCD34D),
    ),
    family: AppCategoryColors(
      base: Color(0xFFFB923C),
      tint: Color(0x33FB923C),
      onTint: Color(0xFFFDBA74),
    ),
    friends: AppCategoryColors(
      base: Color(0xFF818CF8),
      tint: Color(0x33818CF8),
      onTint: Color(0xFFA5B4FC),
    ),
    personal: AppCategoryColors(
      base: Color(0xFFA78BFA),
      tint: Color(0x33A78BFA),
      onTint: Color(0xFFC4B5FD),
    ),
    other: AppCategoryColors(
      base: Color(0xFF94A3B8),
      tint: Color(0x3394A3B8),
      onTint: Color(0xFFCBD5E1),
    ),
    overlaySurface: AppColors.darkOverlay,
    voiceProcessingTrack: Color(0xFFFBBF24),
  );

  @override
  AppSemanticColors copyWith({
    AppStatusColors? success,
    AppStatusColors? warning,
    AppStatusColors? info,
    AppStatusColors? danger,
    AppCategoryColors? medical,
    AppCategoryColors? financial,
    AppCategoryColors? family,
    AppCategoryColors? friends,
    AppCategoryColors? personal,
    AppCategoryColors? other,
    Color? overlaySurface,
    Color? voiceProcessingTrack,
  }) {
    return AppSemanticColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      danger: danger ?? this.danger,
      medical: medical ?? this.medical,
      financial: financial ?? this.financial,
      family: family ?? this.family,
      friends: friends ?? this.friends,
      personal: personal ?? this.personal,
      other: other ?? this.other,
      overlaySurface: overlaySurface ?? this.overlaySurface,
      voiceProcessingTrack: voiceProcessingTrack ?? this.voiceProcessingTrack,
    );
  }

  /// Theme switches snap at the midpoint; token groups are not interpolated.
  @override
  AppSemanticColors lerp(ThemeExtension<AppSemanticColors>? other, double t) {
    if (other is! AppSemanticColors) return this;
    return t < 0.5 ? this : other;
  }
}

extension AppColorsContext on BuildContext {
  /// Semantic + category colors for the current theme.
  AppSemanticColors get appColors => Theme.of(this).extension<AppSemanticColors>() ?? AppSemanticColors.light;
}

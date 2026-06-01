import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_colors.dart';
import 'shared_theme.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  splashFactory: NoSplash.splashFactory,

  // ── Colors ──────────────────────────────────────────────────────────────
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primary,
    onPrimary: AppColors.whiteColor,
    primaryContainer: Color(0xFF4A1515),
    onPrimaryContainer: AppColors.primaryLight,
    secondary: AppColors.secondary,
    onSecondary: AppColors.whiteColor,
    secondaryContainer: Color(0xFF3E2000),
    onSecondaryContainer: Color(0xFFFFCC80),
    surface: AppColors.surfaceDark,
    onSurface: AppColors.textPrimaryDark,
    onSurfaceVariant: AppColors.textSecondaryDark,
    error: Color(0xFFEF5350),
    onError: AppColors.whiteColor,
    outline: AppColors.borderDark,
    outlineVariant: AppColors.dividerDark,
  ),

  // ── Scaffold & Card ──────────────────────────────────────────────────────
  scaffoldBackgroundColor: AppColors.scaffoldDark,
  cardColor: AppColors.cardDark,
  cardTheme: CardThemeData(
    color: AppColors.cardDark,
    elevation: 0,
    shadowColor: Colors.black45,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: AppColors.borderDark, width: 0.5),
    ),
    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
  ),

  // ── Divider ──────────────────────────────────────────────────────────────
  dividerColor: AppColors.dividerDark,
  dividerTheme: const DividerThemeData(
    color: AppColors.dividerDark,
    thickness: 1,
    space: 1,
  ),

  // ── AppBar ──────────────────────────────────────────────────────────────
  appBarTheme: SharedTheme.darkAppBarTheme.copyWith(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: AppColors.scaffoldDark,
      statusBarIconBrightness: Brightness.light,
    ),
  ),

  // ── Text ─────────────────────────────────────────────────────────────────
  textTheme: SharedTheme.darkTextTheme,

  // ── Input ─────────────────────────────────────────────────────────────────
  inputDecorationTheme: SharedTheme.darkInputDecorationTheme,

  // ── Buttons ──────────────────────────────────────────────────────────────
  elevatedButtonTheme: SharedTheme.elevatedButtonTheme,
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primaryLight,
      side: const BorderSide(color: AppColors.primary, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primaryLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    ),
  ),

  // ── TabBar ───────────────────────────────────────────────────────────────
  tabBarTheme: SharedTheme.tabBarTheme.copyWith(
    unselectedLabelColor: AppColors.textSecondaryDark,
    overlayColor: const WidgetStatePropertyAll(Color(0x1FFFFFFF)),
  ),

  // ── Chip ─────────────────────────────────────────────────────────────────
  chipTheme: SharedTheme.darkChipTheme,

  // ── BottomNavigationBar ──────────────────────────────────────────────────
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.surfaceDark,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.textSecondaryDark,
    selectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
    unselectedLabelStyle: TextStyle(fontSize: 11),
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),

  // ── NavigationBar (M3) ───────────────────────────────────────────────────
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: AppColors.surfaceDark,
    indicatorColor: const Color(0xFF4A1515),
    iconTheme: const WidgetStatePropertyAll(
      IconThemeData(color: AppColors.textSecondaryDark),
    ),
    labelTextStyle: const WidgetStatePropertyAll(
      TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
    ),
    elevation: 8,
  ),

  // ── Floating Action Button ───────────────────────────────────────────────
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.whiteColor,
    elevation: 4,
    shape: CircleBorder(),
  ),

  // ── Icon ─────────────────────────────────────────────────────────────────
  iconTheme: const IconThemeData(color: AppColors.textSecondaryDark, size: 24),
  primaryIconTheme: const IconThemeData(color: AppColors.whiteColor, size: 24),

  // ── Switch & Checkbox & Radio ────────────────────────────────────────────
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.primary
          : AppColors.textSecondaryDark,
    ),
    trackColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? const Color(0xFF4A1515)
          : AppColors.borderDark,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.primary
          : Colors.transparent,
    ),
    checkColor: const WidgetStatePropertyAll(AppColors.whiteColor),
    side: const BorderSide(color: AppColors.borderDark, width: 1.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.primary
          : AppColors.textSecondaryDark,
    ),
  ),

  // ── Snackbar ──────────────────────────────────────────────────────────────
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.cardDark,
    contentTextStyle: const TextStyle(color: AppColors.textPrimaryDark, fontSize: 14),
    actionTextColor: AppColors.primaryLight,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // ── Dialog ────────────────────────────────────────────────────────────────
  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.surfaceDark,
    elevation: 8,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    titleTextStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimaryDark,
    ),
    contentTextStyle: const TextStyle(
      fontSize: 14,
      color: AppColors.textSecondaryDark,
    ),
  ),

  // ── ProgressIndicator ─────────────────────────────────────────────────────
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.primary,
    linearTrackColor: Color(0xFF4A1515),
    circularTrackColor: Color(0xFF4A1515),
  ),

  // ── ListTile ──────────────────────────────────────────────────────────────
  listTileTheme: const ListTileThemeData(
    iconColor: AppColors.textSecondaryDark,
    textColor: AppColors.textPrimaryDark,
    subtitleTextStyle: TextStyle(fontSize: 13, color: AppColors.textSecondaryDark),
    titleTextStyle: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimaryDark,
    ),
    tileColor: Colors.transparent,
  ),

  // ── Search ────────────────────────────────────────────────────────────────
  searchBarTheme: SearchBarThemeData(
    backgroundColor: const WidgetStatePropertyAll(AppColors.cardDark),
    elevation: const WidgetStatePropertyAll(0),
    side: const WidgetStatePropertyAll(
      BorderSide(color: AppColors.borderDark),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
);

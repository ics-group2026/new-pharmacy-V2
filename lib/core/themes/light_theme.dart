import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_colors.dart';
import 'shared_theme.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  splashFactory: NoSplash.splashFactory,

  // ── Colors ──────────────────────────────────────────────────────────────
  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: AppColors.whiteColor,
    primaryContainer: AppColors.primaryContainer,
    onPrimaryContainer: AppColors.primaryDark,
    secondary: AppColors.secondary,
    onSecondary: AppColors.whiteColor,
    secondaryContainer: AppColors.secondaryContainer,
    onSecondaryContainer: AppColors.secondaryDark,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.textPrimaryLight,
    onSurfaceVariant: AppColors.textSecondaryLight,
    error: AppColors.error,
    onError: AppColors.whiteColor,
    outline: AppColors.borderLight,
    outlineVariant: AppColors.dividerLight,
  ),

  // ── Scaffold & Card ──────────────────────────────────────────────────────
  scaffoldBackgroundColor: AppColors.scaffoldLight,
  cardColor: AppColors.cardLight,
  cardTheme: CardThemeData(
    color: AppColors.cardLight,
    elevation: 2,
    shadowColor: Colors.black12,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
  ),

  // ── Divider ──────────────────────────────────────────────────────────────
  dividerColor: AppColors.dividerLight,
  dividerTheme: const DividerThemeData(
    color: AppColors.dividerLight,
    thickness: 1,
    space: 1,
  ),

  // ── AppBar ──────────────────────────────────────────────────────────────
  appBarTheme: SharedTheme.lightAppBarTheme.copyWith(
    centerTitle: true,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryDark,
      statusBarIconBrightness: Brightness.light,
    ),
  ),

  // ── Text ─────────────────────────────────────────────────────────────────
  textTheme: SharedTheme.lightTextTheme,

  // ── Input ─────────────────────────────────────────────────────────────────
  inputDecorationTheme: SharedTheme.lightInputDecorationTheme,

  // ── Buttons ──────────────────────────────────────────────────────────────
  elevatedButtonTheme: SharedTheme.elevatedButtonTheme,
  outlinedButtonTheme: SharedTheme.outlinedButtonTheme,
  textButtonTheme: SharedTheme.textButtonTheme,

  // ── TabBar ───────────────────────────────────────────────────────────────
  tabBarTheme: SharedTheme.tabBarTheme,

  // ── Chip ─────────────────────────────────────────────────────────────────
  chipTheme: SharedTheme.lightChipTheme,

  // ── BottomNavigationBar ──────────────────────────────────────────────────
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.surfaceLight,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.greyColor,
    selectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
    unselectedLabelStyle: TextStyle(fontSize: 11),
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),

  // ── NavigationBar (M3) ───────────────────────────────────────────────────
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: AppColors.surfaceLight,
    indicatorColor: AppColors.primaryContainer,
    iconTheme: const WidgetStatePropertyAll(
      IconThemeData(color: AppColors.greyColor),
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
  iconTheme: const IconThemeData(color: AppColors.textSecondaryLight, size: 24),
  primaryIconTheme: const IconThemeData(color: AppColors.whiteColor, size: 24),

  // ── Switch & Checkbox & Radio ────────────────────────────────────────────
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.primary
          : AppColors.greyColor,
    ),
    trackColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.primaryLight
          : AppColors.borderLight,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.primary
          : Colors.transparent,
    ),
    checkColor: const WidgetStatePropertyAll(AppColors.whiteColor),
    side: const BorderSide(color: AppColors.borderLight, width: 1.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.primary
          : AppColors.greyColor,
    ),
  ),

  // ── Snackbar ──────────────────────────────────────────────────────────────
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.textPrimaryLight,
    contentTextStyle: const TextStyle(color: AppColors.whiteColor, fontSize: 14),
    actionTextColor: AppColors.primaryLight,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // ── Dialog ────────────────────────────────────────────────────────────────
  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.surfaceLight,
    elevation: 8,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    titleTextStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimaryLight,
    ),
    contentTextStyle: const TextStyle(
      fontSize: 14,
      color: AppColors.textSecondaryLight,
    ),
  ),

  // ── ProgressIndicator ─────────────────────────────────────────────────────
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.primary,
    linearTrackColor: AppColors.primaryContainer,
    circularTrackColor: AppColors.primaryContainer,
  ),

  // ── ListTile ──────────────────────────────────────────────────────────────
  listTileTheme: const ListTileThemeData(
    iconColor: AppColors.textSecondaryLight,
    textColor: AppColors.textPrimaryLight,
    subtitleTextStyle: TextStyle(fontSize: 13, color: AppColors.textSecondaryLight),
    titleTextStyle: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimaryLight,
    ),
  ),

  // ── Search ────────────────────────────────────────────────────────────────
  searchBarTheme: SearchBarThemeData(
    backgroundColor: const WidgetStatePropertyAll(AppColors.surfaceLight),
    elevation: const WidgetStatePropertyAll(0),
    side: const WidgetStatePropertyAll(BorderSide(color: AppColors.borderLight)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
);

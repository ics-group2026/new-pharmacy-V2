import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharamacy_theme_v1/core/widgets/language_switcher.dart';
import 'package:new_pharamacy_theme_v1/core/widgets/t_text.dart';
import 'package:new_pharamacy_theme_v1/core/widgets/theme_switcher.dart';
import 'package:new_pharamacy_theme_v1/features/account/presentation/widgets/settings_card.dart';
import 'package:new_pharamacy_theme_v1/features/account/presentation/widgets/settings_tile.dart';

class AccountPreferanceContent extends StatelessWidget {
  const AccountPreferanceContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.verticalSpace,
          TText(
            'account.preferences',
            style: theme.textTheme.labelLarge?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.5),
              letterSpacing: 0.8,
            ),
          ),
          12.verticalSpace,
          SettingsCard(
            children: [
              const LanguageSwitcher(),
              Divider(height: 1, color: colorScheme.outlineVariant),
              const ThemeSwitcher(),
            ],
          ),
          24.verticalSpace,
          TText(
            'nav_bar.account',
            style: theme.textTheme.labelLarge?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.5),
              letterSpacing: 0.8,
            ),
          ),
          12.verticalSpace,
          SettingsCard(
            children: [
              SettingsTile(
                icon: Icons.receipt_long_rounded,
                titleKey: 'account.my_orders',
                onTap: () {},
              ),
              Divider(height: 1, color: colorScheme.outlineVariant),
              SettingsTile(
                icon: Icons.notifications_outlined,
                titleKey: 'account.notifications',
                onTap: () {},
              ),
              Divider(height: 1, color: colorScheme.outlineVariant),
              SettingsTile(
                icon: Icons.help_outline_rounded,
                titleKey: 'account.help_support',
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }
}

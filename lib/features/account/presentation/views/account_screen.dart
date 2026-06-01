import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_translations.dart';
import '../../../../../core/widgets/language_switcher.dart';
import '../../../../../core/widgets/theme_switcher.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.h,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryDark, AppColors.primary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      40.verticalSpace,
                      Container(
                        width: 72.r,
                        height: 72.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.2),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 2),
                        ),
                        child: Icon(Icons.person_rounded, size: 38.r, color: Colors.white),
                      ),
                      12.verticalSpace,
                      Text(
                        AppTranslations.t('home.user_name'),
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      4.verticalSpace,
                      Text(
                        'user@pharmacy.com',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.75),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            title: Text(
              AppTranslations.t('nav_bar.account'),
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.primaryDark,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.verticalSpace,
                  Text(
                    'Preferences',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                      letterSpacing: 0.8,
                    ),
                  ),
                  12.verticalSpace,
                  _SettingsCard(
                    children: [
                      const LanguageSwitcher(),
                      Divider(height: 1, color: colorScheme.outlineVariant),
                      ThemeSwitcher(),
                    ],
                  ),
                  24.verticalSpace,
                  Text(
                    'Account',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                      letterSpacing: 0.8,
                    ),
                  ),
                  12.verticalSpace,
                  _SettingsCard(
                    children: [
                      _SettingsTile(
                        icon: Icons.receipt_long_rounded,
                        title: 'My Orders',
                        onTap: () {},
                      ),
                      Divider(height: 1, color: colorScheme.outlineVariant),
                      _SettingsTile(
                        icon: Icons.notifications_outlined,
                        title: 'Notifications',
                        onTap: () {},
                      ),
                      Divider(height: 1, color: colorScheme.outlineVariant),
                      _SettingsTile(
                        icon: Icons.help_outline_rounded,
                        title: 'Help & Support',
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({required this.icon, required this.title, required this.onTap});

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, size: 20.r, color: colorScheme.primary),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14.r, color: colorScheme.onSurface.withValues(alpha: 0.4)),
    );
  }
}

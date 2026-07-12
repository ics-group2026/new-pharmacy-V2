import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_pharmacy_v2/core/routes/app_routes.dart';
import 'package:new_pharmacy_v2/core/utils/app_colors.dart';
import 'package:new_pharmacy_v2/core/widgets/language_switcher.dart';
import 'package:new_pharmacy_v2/core/widgets/t_text.dart';
import 'package:new_pharmacy_v2/core/widgets/theme_switcher.dart';
import 'package:new_pharmacy_v2/features/account/presentation/widgets/settings_card.dart';
import 'package:new_pharmacy_v2/features/account/presentation/widgets/settings_tile.dart';
import 'package:new_pharmacy_v2/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:new_pharmacy_v2/features/auth/presentation/cubits/auth_state.dart';

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
                icon: Icons.person_outline_rounded,
                titleKey: 'account.edit_profile',
                onTap: () => context.push(AppRoutes.profile),
              ),
              Divider(height: 1, color: colorScheme.outlineVariant),
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
          24.verticalSpace,
          const _LogoutButton(),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: TText('account.logout_confirm_title'),
        content: TText('account.logout_confirm_message'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: TText('common.cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: TText(
              'account.logout',
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      context.read<AuthCubit>().logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 50.h,
          child: OutlinedButton.icon(
            onPressed:
                state.isLoading ? null : () => _confirmLogout(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.error,
              side: const BorderSide(color: AppColors.error),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            icon: state.isLoading
                ? SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.error,
                    ),
                  )
                : const Icon(Icons.logout_rounded),
            label: TText('account.logout'),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_pharmacy_v2/core/routes/app_routes.dart';
import 'package:new_pharmacy_v2/features/account/presentation/widgets/settings_card.dart';
import 'package:new_pharmacy_v2/features/account/presentation/widgets/settings_divider.dart';
import 'package:new_pharmacy_v2/features/account/presentation/widgets/settings_tile.dart';

class AccountSettingsCard extends StatelessWidget {
  const AccountSettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      children: [
        SettingsTile(
          icon: Icons.person_outline_rounded,
          titleKey: 'account.edit_profile',
          onTap: () => context.push(AppRoutes.profile),
        ),
        const SettingsDivider(),
        SettingsTile(
          icon: Icons.receipt_long_rounded,
          titleKey: 'account.my_orders',
          onTap: () {},
        ),
        const SettingsDivider(),
        SettingsTile(
          icon: Icons.notifications_outlined,
          titleKey: 'account.notifications',
          onTap: () => context.push(AppRoutes.notifications),
        ),
        const SettingsDivider(),
        SettingsTile(
          icon: Icons.help_outline_rounded,
          titleKey: 'account.help_support',
          onTap: () {},
        ),
      ],
    );
  }
}

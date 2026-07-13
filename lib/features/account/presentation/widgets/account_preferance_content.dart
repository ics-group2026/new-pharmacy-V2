import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/features/account/presentation/widgets/account_settings_card.dart';
import 'package:new_pharmacy_v2/features/account/presentation/widgets/delete_account_button.dart';
import 'package:new_pharmacy_v2/features/account/presentation/widgets/logout_button.dart';
import 'package:new_pharmacy_v2/features/account/presentation/widgets/preferences_card.dart';
import 'package:new_pharmacy_v2/features/account/presentation/widgets/settings_section_title.dart';

class AccountPreferanceContent extends StatelessWidget {
  const AccountPreferanceContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.verticalSpace,
          const SettingsSectionTitle(titleKey: 'account.preferences'),
          12.verticalSpace,
          const PreferencesCard(),
          24.verticalSpace,
          const SettingsSectionTitle(titleKey: 'nav_bar.account'),
          12.verticalSpace,
          const AccountSettingsCard(),
          24.verticalSpace,
          const LogoutButton(),
          8.verticalSpace,
          const DeleteAccountButton(),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }
}

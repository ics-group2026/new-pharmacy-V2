import 'package:flutter/material.dart';
import 'package:new_pharmacy_v2/core/widgets/language_switcher.dart';
import 'package:new_pharmacy_v2/core/widgets/theme_switcher.dart';
import 'package:new_pharmacy_v2/features/account/presentation/widgets/settings_card.dart';
import 'package:new_pharmacy_v2/features/account/presentation/widgets/settings_divider.dart';

class PreferencesCard extends StatelessWidget {
  const PreferencesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsCard(
      children: [LanguageSwitcher(), SettingsDivider(), ThemeSwitcher()],
    );
  }
}

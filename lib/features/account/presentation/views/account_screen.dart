import 'package:flutter/material.dart';
import 'package:new_pharamacy_theme_v1/core/widgets/theme_switcher.dart';

import '../../../../../core/widgets/language_switcher.dart';
import '../../../../../core/widgets/t_text.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TText('nav_bar.account')),
      body: Column(
        children: [
          const LanguageSwitcher(),
          ThemeSwitcher(),
        ],
      ),
    );
  }
}

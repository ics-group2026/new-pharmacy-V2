import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../themes/theme_cubit/theme_cubit.dart';
import 't_text.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<ThemeCubit, bool>(
      (cubit) => cubit.state.brightness == Brightness.dark,
    );

    return ListTile(
      leading: const Icon(Icons.dark_mode_outlined),
      title: const TText('account.dark_mode'),
      trailing: Switch(
        inactiveThumbColor: Colors.grey,
        activeThumbColor: Theme.of(context).primaryColor,
        activeTrackColor: Colors.grey.shade700,
        value: isDark,
        onChanged: (value) => context.read<ThemeCubit>().setTheme(value),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../themes/theme_cubit/theme_cubit.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  @override
  Widget build(BuildContext context) {
    final isDark = context.select<ThemeCubit, bool>(
      (cubit) => cubit.state.brightness == Brightness.dark,
    );

    return Switch(
      inactiveThumbColor: Colors.grey,
      activeThumbColor: Theme.of(context).primaryColor,
      activeTrackColor: Colors.grey.shade700,
      value: isDark,
      onChanged: (value) {
        context.read<ThemeCubit>().setTheme(value);
      },
    );
  }
}

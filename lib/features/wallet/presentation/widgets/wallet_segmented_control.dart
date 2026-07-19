import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_translations.dart';
import '../../../../core/widgets/pill_chip.dart';

/// Switches between the money and loyalty histories. Uses [PillChip] rather
/// than a TabBar: the app has no tab usage and the shared tabBarTheme is
/// white-on-white outside a coloured app bar.
class WalletSegmentedControl extends StatelessWidget {
  const WalletSegmentedControl({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const _labelKeys = ['wallet.tab_transactions', 'wallet.tab_loyalty'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < _labelKeys.length; i++) ...[
          if (i > 0) 8.horizontalSpace,
          PillChip(
            label: AppTranslations.t(_labelKeys[i]),
            isSelected: selectedIndex == i,
            onTap: () => onSelected(i),
          ),
        ],
      ],
    );
  }
}

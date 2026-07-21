import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/core/constants/hero_tags.dart';
import 'package:new_pharmacy_v2/core/widgets/search_field_bar.dart';

import 'filter_button.dart';

/// Hero-animated search field plus the filters button, side by side.
class SearchBarRow extends StatelessWidget {
  const SearchBarRow({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onQueryChanged,
    required this.activeFilterCount,
    required this.onFilterTap,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onQueryChanged;
  final int activeFilterCount;
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Hero(
            tag: HeroTags.searchBar,
            child: SearchFieldBar(
              controller: controller,
              focusNode: focusNode,
              onChanged: onQueryChanged,
            ),
          ),
        ),
        10.horizontalSpace,
        FilterButton(activeCount: activeFilterCount, onTap: onFilterTap),
      ],
    );
  }
}

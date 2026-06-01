import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_translations.dart';
import '../../../../../core/widgets/pill_chip.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  int _selectedIndex = 0;

  static const _categories = [
    _Category('categories.personal_care', Icons.face_retouching_natural_rounded),
    _Category('categories.perfume', Icons.spa_rounded),
    _Category('categories.hair_care', Icons.content_cut_rounded),
    _Category('categories.skin_care', Icons.water_drop_rounded),
    _Category('categories.face_makeup', Icons.brush_rounded),
    _Category('categories.vitamins', Icons.medication_rounded),
    _Category('categories.baby_care', Icons.child_care_rounded),
    _Category('categories.dental', Icons.medical_services_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: _categories.length,
        separatorBuilder: (_, _) => 8.horizontalSpace,
        itemBuilder: (_, index) {
          final category = _categories[index];
          return PillChip(
            label: AppTranslations.t(category.labelKey),
            icon: category.icon,
            isSelected: _selectedIndex == index,
            onTap: () => setState(() => _selectedIndex = index),
          );
        },
      ),
    );
  }
}

class _Category {
  const _Category(this.labelKey, this.icon);

  final String labelKey;
  final IconData icon;
}

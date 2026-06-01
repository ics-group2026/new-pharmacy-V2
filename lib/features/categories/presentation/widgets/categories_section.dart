import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/title_with_see_all.dart';
import 'category_item.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  static const _categories = [
    (
      labelKey: 'categories.personal_care',
      icon: Icons.face_retouching_natural_rounded,
      background: Color(0xFFFFCDD2),
      iconColor: Color(0xFFE53935),
    ),
    (
      labelKey: 'categories.perfume',
      icon: Icons.spa_rounded,
      background: Color(0xFFE1BEE7),
      iconColor: Color(0xFF8E24AA),
    ),
    (
      labelKey: 'categories.hair_care',
      icon: Icons.content_cut_rounded,
      background: Color(0xFFB3E5FC),
      iconColor: Color(0xFF0288D1),
    ),
    (
      labelKey: 'categories.skin_care',
      icon: Icons.water_drop_rounded,
      background: Color(0xFFC8E6C9),
      iconColor: Color(0xFF388E3C),
    ),
    (
      labelKey: 'categories.face_makeup',
      icon: Icons.brush_rounded,
      background: Color(0xFFFFCCBC),
      iconColor: Color(0xFFE64A19),
    ),
    (
      labelKey: 'categories.vitamins',
      icon: Icons.medication_rounded,
      background: Color(0xFFFFF9C4),
      iconColor: Color(0xFFF9A825),
    ),
    (
      labelKey: 'categories.baby_care',
      icon: Icons.child_care_rounded,
      background: Color(0xFFF8BBD0),
      iconColor: Color(0xFFD81B60),
    ),
    (
      labelKey: 'categories.dental',
      icon: Icons.medical_services_rounded,
      background: Color(0xFFB2EBF2),
      iconColor: Color(0xFF00838F),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWithSeeAll(titleKey: 'categories.title', onSeeAll: () {}),
        12.verticalSpace,
        SizedBox(
          height: 100.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (_, _) => 8.horizontalSpace,
            itemBuilder: (_, index) {
              final cat = _categories[index];
              return CategoryItem(
                labelKey: cat.labelKey,
                icon: cat.icon,
                backgroundColor: cat.background,
                iconColor: cat.iconColor,
              );
            },
          ),
        ),
      ],
    );
  }
}

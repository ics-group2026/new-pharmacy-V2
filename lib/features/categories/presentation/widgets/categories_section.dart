import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/services/setup_service_locator.dart';
import '../../../../../core/widgets/empty_data_placeholder.dart';
import '../../../../../core/widgets/pill_chip.dart';
import '../../data/repos/categories_repo.dart';
import '../cubits/categories_cubit.dart';
import '../cubits/categories_state.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoriesCubit(getIt<CategoriesRepo>())..getCategories(),
      child: const _CategoriesBody(),
    );
  }
}

class _CategoriesBody extends StatefulWidget {
  const _CategoriesBody();

  @override
  State<_CategoriesBody> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<_CategoriesBody> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return SizedBox(
      height: 44.h,
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state.status == CategoriesStatus.loading ||
              state.status == CategoriesStatus.initial) {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: 5,
              separatorBuilder: (_, _) => 8.horizontalSpace,
              itemBuilder: (_, _) => _CategoryPillShimmer(),
            );
          }

          if (state.status == CategoriesStatus.error) {
            return const SizedBox.shrink();
          }

          if (state.categories.isEmpty) {
            return const EmptyDataPlaceholder();
          }

          final categories = state.categories;
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: categories.length,
            separatorBuilder: (_, _) => 8.horizontalSpace,
            itemBuilder: (_, index) {
              final category = categories[index];
              final label = (isArabic ? category.arName : category.enName) ?? '';
              return PillChip(
                label: label,
                isSelected: _selectedIndex == index,
                onTap: () => setState(() => _selectedIndex = index),
              );
            },
          );
        },
      ),
    );
  }
}

class _CategoryPillShimmer extends StatelessWidget {
  const _CategoryPillShimmer();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 72.w,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24.r),
      ),
    );
  }
}

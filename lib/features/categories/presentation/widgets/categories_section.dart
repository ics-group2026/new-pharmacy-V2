import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/services/setup_service_locator.dart';
import '../../../../../core/widgets/empty_data_placeholder.dart';
import '../../../../../core/widgets/section_header.dart';
import '../../data/repos/categories_repo.dart';
import '../cubits/categories_cubit.dart';
import '../cubits/categories_state.dart';
import 'category_circle_item.dart';

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

class _CategoriesBody extends StatelessWidget {
  const _CategoriesBody();

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state.status == CategoriesStatus.error) {
          return const SizedBox.shrink();
        }

        final isLoading =
            state.status == CategoriesStatus.initial ||
            state.status == CategoriesStatus.loading;
        final isEmpty =
            state.status == CategoriesStatus.loaded && state.categories.isEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(titleKey: 'categories.title'),
            12.verticalSpace,
            SizedBox(
              height: 100.h,
              child: isLoading
                  ? const _CategoriesLoading()
                  : isEmpty
                  ? const EmptyDataPlaceholder()
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      itemCount: state.categories.length,
                      separatorBuilder: (_, _) => 16.horizontalSpace,
                      itemBuilder: (_, index) {
                        final category = state.categories[index];
                        final label =
                            (isArabic ? category.arName : category.enName) ?? '';
                        return CategoryCircleItem(category: category, label: label);
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}

class _CategoriesLoading extends StatelessWidget {
  const _CategoriesLoading();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.zero,
      itemCount: 5,
      separatorBuilder: (_, _) => 16.horizontalSpace,
      itemBuilder: (_, _) => const _CategoryCircleShimmer(),
    );
  }
}

class _CategoryCircleShimmer extends StatelessWidget {
  const _CategoryCircleShimmer();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 60.r,
      height: 60.r,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        shape: BoxShape.circle,
      ),
    );
  }
}

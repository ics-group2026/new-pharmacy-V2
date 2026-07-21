import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/core/services/setup_service_locator.dart';
import 'package:new_pharmacy_v2/core/utils/app_translations.dart';
import 'package:new_pharmacy_v2/core/widgets/pill_chip.dart';
import 'package:new_pharmacy_v2/features/brands/data/repos/brands_repo.dart';
import 'package:new_pharmacy_v2/features/brands/presentation/cubits/brands_cubit.dart';
import 'package:new_pharmacy_v2/features/brands/presentation/cubits/brands_state.dart';
import 'package:new_pharmacy_v2/features/categories/data/repos/categories_repo.dart';
import 'package:new_pharmacy_v2/features/categories/presentation/cubits/categories_cubit.dart';
import 'package:new_pharmacy_v2/features/categories/presentation/cubits/categories_state.dart';
import 'package:new_pharmacy_v2/features/search/data/models/search_filters.dart';

/// Opens the filter bottom sheet and resolves with the applied filters, or
/// null if the user dismissed it without applying.
Future<SearchFilters?> showSearchFiltersSheet(
  BuildContext context, {
  required SearchFilters initialFilters,
}) {
  return showModalBottomSheet<SearchFilters>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => SearchFiltersSheet(initialFilters: initialFilters),
  );
}

class SearchFiltersSheet extends StatefulWidget {
  const SearchFiltersSheet({super.key, required this.initialFilters});

  final SearchFilters initialFilters;

  @override
  State<SearchFiltersSheet> createState() => _SearchFiltersSheetState();
}

class _SearchFiltersSheetState extends State<SearchFiltersSheet> {
  late SearchFilters _filters;
  late final TextEditingController _minController;
  late final TextEditingController _maxController;

  @override
  void initState() {
    super.initState();
    _filters = widget.initialFilters;
    _minController = TextEditingController(
      text: _filters.minPrice?.toStringAsFixed(0) ?? '',
    );
    _maxController = TextEditingController(
      text: _filters.maxPrice?.toStringAsFixed(0) ?? '',
    );
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  void _syncPriceRange() {
    _filters = _filters.copyWith(
      minPrice: double.tryParse(_minController.text),
      maxPrice: double.tryParse(_maxController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isArabic = context.locale.languageCode == 'ar';

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.85),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            8.verticalSpace,
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: colorScheme.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      AppTranslations.t('search.filters_title'),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => setState(() {
                      _filters = const SearchFilters();
                      _minController.clear();
                      _maxController.clear();
                    }),
                    child: Text(AppTranslations.t('search.reset')),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SheetSectionTitle(AppTranslations.t('search.sort_by')),
                    12.verticalSpace,
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        PillChip(
                          label: AppTranslations.t('search.sort_relevance'),
                          isSelected: _filters.sortOrder == SearchSortOrder.relevance,
                          onTap: () => setState(
                            () => _filters = _filters.copyWith(
                              sortOrder: SearchSortOrder.relevance,
                            ),
                          ),
                        ),
                        PillChip(
                          label: AppTranslations.t('search.sort_price_asc'),
                          isSelected: _filters.sortOrder == SearchSortOrder.priceAsc,
                          onTap: () => setState(
                            () => _filters = _filters.copyWith(
                              sortOrder: SearchSortOrder.priceAsc,
                            ),
                          ),
                        ),
                        PillChip(
                          label: AppTranslations.t('search.sort_price_desc'),
                          isSelected: _filters.sortOrder == SearchSortOrder.priceDesc,
                          onTap: () => setState(
                            () => _filters = _filters.copyWith(
                              sortOrder: SearchSortOrder.priceDesc,
                            ),
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    _SheetSectionTitle(AppTranslations.t('search.price_range')),
                    12.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: _PriceField(
                            controller: _minController,
                            hintKey: 'search.min_price',
                            onChanged: (_) => _syncPriceRange(),
                          ),
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: _PriceField(
                            controller: _maxController,
                            hintKey: 'search.max_price',
                            onChanged: (_) => _syncPriceRange(),
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    _SheetSectionTitle(AppTranslations.t('search.category')),
                    12.verticalSpace,
                    BlocProvider(
                      create: (_) =>
                          CategoriesCubit(getIt<CategoriesRepo>())..getCategories(),
                      child: BlocBuilder<CategoriesCubit, CategoriesState>(
                        builder: (context, state) {
                          if (state.categories.isEmpty) return const SizedBox.shrink();
                          return Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children: [
                              for (final category in state.categories)
                                PillChip(
                                  label:
                                      (isArabic ? category.arName : category.enName) ??
                                      '',
                                  isSelected: _filters.categoryId == category.id,
                                  onTap: () => setState(() {
                                    _filters = _filters.categoryId == category.id
                                        ? _filters.clearCategory()
                                        : _filters.copyWith(
                                            categoryId: category.id,
                                            categoryLabel:
                                                (isArabic
                                                    ? category.arName
                                                    : category.enName) ??
                                                '',
                                          );
                                  }),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                    20.verticalSpace,
                    _SheetSectionTitle(AppTranslations.t('search.brand')),
                    12.verticalSpace,
                    BlocProvider(
                      create: (_) => BrandsCubit(getIt<BrandsRepo>())..getBrands(),
                      child: BlocBuilder<BrandsCubit, BrandsState>(
                        builder: (context, state) {
                          if (state.brands.isEmpty) return const SizedBox.shrink();
                          return Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children: [
                              for (final brand in state.brands)
                                PillChip(
                                  label: brand.name ?? '',
                                  isSelected: _filters.brandId == brand.id,
                                  onTap: () => setState(() {
                                    _filters = _filters.brandId == brand.id
                                        ? _filters.clearBrand()
                                        : _filters.copyWith(
                                            brandId: brand.id,
                                            brandLabel: brand.name ?? '',
                                          );
                                  }),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                    12.verticalSpace,
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
              child: SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    _syncPriceRange();
                    Navigator.of(context).pop(_filters);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Text(
                    _filters.activeCount > 0
                        ? AppTranslations.t(
                            'search.apply_with_count',
                            namedArgs: {'count': '${_filters.activeCount}'},
                          )
                        : AppTranslations.t('search.apply'),
                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetSectionTitle extends StatelessWidget {
  const _SheetSectionTitle(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(
        context,
      ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _PriceField extends StatelessWidget {
  const _PriceField({
    required this.controller,
    required this.hintKey,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hintKey;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: const TextInputType.numberWithOptions(decimal: false),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        isDense: true,
        hintText: AppTranslations.t(hintKey),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/core/utils/app_translations.dart';
import 'package:new_pharmacy_v2/features/search/data/models/search_filters.dart';

/// Removable chips summarizing the currently applied [filters]. Renders
/// nothing when no filter is active.
class ActiveFiltersRow extends StatelessWidget {
  const ActiveFiltersRow({super.key, required this.filters, required this.onChanged});

  final SearchFilters filters;
  final ValueChanged<SearchFilters> onChanged;

  @override
  Widget build(BuildContext context) {
    if (filters.isEmpty) return const SizedBox.shrink();

    final chips = <Widget>[
      if (filters.categoryId != null)
        _FilterChip(
          label: filters.categoryLabel ?? AppTranslations.t('search.category'),
          onRemove: () => onChanged(filters.clearCategory()),
        ),
      if (filters.brandId != null)
        _FilterChip(
          label: filters.brandLabel ?? AppTranslations.t('search.brand'),
          onRemove: () => onChanged(filters.clearBrand()),
        ),
      if (filters.minPrice != null || filters.maxPrice != null)
        _FilterChip(
          icon: Icons.sell_rounded,
          label:
              '${filters.minPrice?.toStringAsFixed(0) ?? '0'} - ${filters.maxPrice?.toStringAsFixed(0) ?? '∞'} ${AppTranslations.t('flash_deals.currency')}',
          onRemove: () => onChanged(filters.clearPriceRange()),
        ),
      if (filters.sortOrder != SearchSortOrder.relevance)
        _FilterChip(
          label: AppTranslations.t(
            filters.sortOrder == SearchSortOrder.priceAsc
                ? 'search.sort_price_asc'
                : 'search.sort_price_desc',
          ),
          onRemove: () => onChanged(filters.clearSort()),
        ),
    ];

    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: chips.length,
        separatorBuilder: (_, _) => 8.horizontalSpace,
        itemBuilder: (_, index) => chips[index],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.onRemove, this.icon});

  final String label;
  final VoidCallback onRemove;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13.r, color: colorScheme.primary),
            4.horizontalSpace,
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            ),
          ),
          6.horizontalSpace,
          GestureDetector(
            onTap: onRemove,
            child: Icon(Icons.close_rounded, size: 14.r, color: colorScheme.primary),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/core/utils/app_translations.dart';
import 'package:new_pharmacy_v2/core/widgets/animated_fade_slide.dart';
import 'package:new_pharmacy_v2/core/widgets/product_card.dart';
import 'package:new_pharmacy_v2/features/products/presentation/widgets/products_loading.dart';
import 'package:new_pharmacy_v2/features/search/presentation/cubits/search_cubit.dart';
import 'package:new_pharmacy_v2/features/search/presentation/cubits/search_state.dart';

/// Renders the loading / error / empty / loaded states for search results,
/// with a staggered fade-in for the first screenful of cards.
class SearchResultsGrid extends StatelessWidget {
  const SearchResultsGrid({
    super.key,
    required this.state,
    required this.scrollController,
  });

  final SearchState state;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (state.status == SearchStatus.loading) {
      return const ProductsGridLoading();
    }

    if (state.status == SearchStatus.error && state.products.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 56.r,
              color: colorScheme.error.withValues(alpha: 0.6),
            ),
            16.verticalSpace,
            Text(
              AppTranslations.t('search.error_title'),
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            8.verticalSpace,
            Text(
              state.errorMessage ?? AppTranslations.t('common.no_data'),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            16.verticalSpace,
            TextButton(
              onPressed: () => context.read<SearchCubit>().submitSearch(state.query),
              child: Text(AppTranslations.t('common.retry')),
            ),
          ],
        ),
      );
    }

    if (state.products.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 56.r,
                color: colorScheme.onSurface.withValues(alpha: 0.18),
              ),
              16.verticalSpace,
              Text(
                AppTranslations.t('search.no_results_title'),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              8.verticalSpace,
              Text(
                AppTranslations.t('search.no_results_subtitle'),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => context.read<SearchCubit>().submitSearch(state.query),
      child: GridView.builder(
        controller: scrollController,
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 16.h,
          mainAxisExtent: 290.h,
        ),
        itemCount: state.products.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= state.products.length) {
            return const Center(child: CircularProgressIndicator());
          }
          final card = ProductCard(
            product: state.products[index],
            enableHero: false,
            bottomPadding: 4.h,
          );
          // Only the first screenful staggers in — later pages (loadMore)
          // appear instantly so scrolling doesn't keep re-triggering fades.
          if (index >= 10) return card;
          return AnimatedFadeSlide(
            delay: Duration(milliseconds: 30 * index),
            duration: const Duration(milliseconds: 300),
            child: card,
          );
        },
      ),
    );
  }
}

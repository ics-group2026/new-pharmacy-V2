import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/setup_service_locator.dart';
import '../../../../core/utils/app_translations.dart';
import '../../../../core/widgets/empty_data_placeholder.dart';
import '../../../../core/widgets/product_card.dart';
import '../../data/repos/products_repo.dart';
import '../cubits/filtered_products_cubit.dart';
import '../cubits/filtered_products_state.dart';
import '../widgets/products_loading.dart';

class FilteredProductsScreen extends StatelessWidget {
  const FilteredProductsScreen({
    super.key,
    required this.title,
    this.categoryId,
    this.brandId,
  });

  final String title;
  final String? categoryId;
  final String? brandId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FilteredProductsCubit(
        getIt<ProductsRepo>(),
        categoryId: categoryId,
        brandId: brandId,
      )..getProducts(),
      child: _FilteredProductsBody(title: title),
    );
  }
}

class _FilteredProductsBody extends StatefulWidget {
  const _FilteredProductsBody({required this.title});

  final String title;

  @override
  State<_FilteredProductsBody> createState() => _FilteredProductsBodyState();
}

class _FilteredProductsBodyState extends State<_FilteredProductsBody> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<FilteredProductsCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(widget.title)),
      body: BlocBuilder<FilteredProductsCubit, FilteredProductsState>(
        builder: (context, state) {
          if (state.status == FilteredProductsStatus.loading ||
              state.status == FilteredProductsStatus.initial) {
            return const ProductsGridLoading();
          }

          if (state.status == FilteredProductsStatus.error) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.errorMessage ?? AppTranslations.t('common.no_data'),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  12.verticalSpace,
                  TextButton(
                    onPressed: () =>
                        context.read<FilteredProductsCubit>().getProducts(),
                    child: Text(AppTranslations.t('common.retry')),
                  ),
                ],
              ),
            );
          }

          if (state.products.isEmpty) {
            return const EmptyDataPlaceholder();
          }

          return RefreshIndicator(
            onRefresh: () => context.read<FilteredProductsCubit>().getProducts(),
            child: GridView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16.r),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 16.h,
                childAspectRatio: 0.65,
              ),
              itemCount: state.products.length + (state.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= state.products.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ProductCard(
                  product: state.products[index],
                  enableHero: false,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

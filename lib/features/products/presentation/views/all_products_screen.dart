import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/setup_service_locator.dart';
import '../../../../core/utils/app_translations.dart';
import '../../../../core/widgets/empty_data_placeholder.dart';
import '../../../../core/widgets/product_card.dart';
import '../../data/repos/products_repo.dart';
import '../cubits/products_cubit.dart';
import '../cubits/products_state.dart';
import '../widgets/products_loading.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsCubit(getIt<ProductsRepo>())..getProducts(),
      child: const _AllProductsBody(),
    );
  }
}

class _AllProductsBody extends StatefulWidget {
  const _AllProductsBody();

  @override
  State<_AllProductsBody> createState() => _AllProductsBodyState();
}

class _AllProductsBodyState extends State<_AllProductsBody> {
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
      context.read<ProductsCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(AppTranslations.t('products.all_products'))),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state.status == ProductsStatus.loading ||
              state.status == ProductsStatus.initial) {
            return const ProductsGridLoading();
          }

          if (state.status == ProductsStatus.error && state.products.isEmpty) {
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
                    onPressed: () => context.read<ProductsCubit>().getProducts(),
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
            onRefresh: () => context.read<ProductsCubit>().getProducts(),
            child: GridView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16.r),
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

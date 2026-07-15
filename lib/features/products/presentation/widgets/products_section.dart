import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/setup_service_locator.dart';
import '../../../../core/widgets/section_header.dart';
import '../../data/repos/products_repo.dart';
import '../cubits/products_cubit.dart';
import '../cubits/products_state.dart';
import 'products_list.dart';
import 'products_loading.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsCubit(getIt<ProductsRepo>())..getProducts(),
      child: _ProductsBody(onSeeAll: onSeeAll),
    );
  }
}

class _ProductsBody extends StatelessWidget {
  const _ProductsBody({this.onSeeAll});

  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        // A dead section is worse than no section — stay quiet on failure,
        // and once loaded with nothing to sell, take the space back.
        if (state.status == ProductsStatus.error) {
          return const SizedBox.shrink();
        }
        if (state.status == ProductsStatus.loaded && state.products.isEmpty) {
          return const SizedBox.shrink();
        }

        final isLoading =
            state.status == ProductsStatus.initial ||
            state.status == ProductsStatus.loading;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(titleKey: 'products.all_products', onSeeAll: onSeeAll),
            12.verticalSpace,
            if (isLoading)
              const ProductsLoading()
            else
              ProductsList(products: state.products),
          ],
        );
      },
    );
  }
}

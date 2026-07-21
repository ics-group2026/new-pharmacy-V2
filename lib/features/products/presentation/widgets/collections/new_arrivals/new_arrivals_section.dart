import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/features/products/data/models/product_collections.dart';
import 'package:new_pharmacy_v2/features/products/data/repos/products_repo.dart';
import 'package:new_pharmacy_v2/features/products/presentation/cubits/products_cubit.dart';
import 'package:new_pharmacy_v2/features/products/presentation/cubits/products_state.dart';

import 'package:new_pharmacy_v2/core/services/setup_service_locator.dart';
import 'package:new_pharmacy_v2/core/widgets/section_header.dart';
import 'new_arrival_item.dart';

class NewArrivalsSection extends StatelessWidget {
  const NewArrivalsSection({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsCubit(
        getIt<ProductsRepo>(),
        collection: ProductCollections.newArrivals,
      )..getProducts(),
      child: _NewArrivalsBody(onSeeAll: onSeeAll),
    );
  }
}

class _NewArrivalsBody extends StatelessWidget {
  const _NewArrivalsBody({this.onSeeAll});

  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        // Hide the whole banded section rather than leave an empty colour block.
        if (state.status == ProductsStatus.error) {
          return const SizedBox.shrink();
        }
        if (state.status == ProductsStatus.loaded && state.products.isEmpty) {
          return const SizedBox.shrink();
        }

        final isLoading =
            state.status == ProductsStatus.initial ||
            state.status == ProductsStatus.loading;

        return Container(
          width: double.infinity,
          color: colorScheme.primaryContainer,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(titleKey: 'new_arrivals.title', onSeeAll: onSeeAll),
              12.verticalSpace,
              SizedBox(
                height: 270.h,
                child: isLoading
                    ? const _NewArrivalsLoading()
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        itemCount: state.products.length,
                        separatorBuilder: (_, _) => 12.horizontalSpace,
                        itemBuilder: (_, index) =>
                            NewArrivalItem(item: state.products[index]),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NewArrivalsLoading extends StatelessWidget {
  const _NewArrivalsLoading();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.zero,
      itemCount: 4,
      separatorBuilder: (_, _) => 12.horizontalSpace,
      itemBuilder: (_, _) => Container(
        width: 160.w,
        decoration: BoxDecoration(
          color: colorScheme.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
    );
  }
}

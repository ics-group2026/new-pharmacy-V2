import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/setup_service_locator.dart';
import '../../../../core/widgets/empty_data_placeholder.dart';
import '../../../../core/widgets/section_header.dart';
import '../../data/repos/brands_repo.dart';
import '../cubits/brands_cubit.dart';
import '../cubits/brands_state.dart';
import 'brand_item.dart';
import 'brands_loading.dart';

class BrandsSection extends StatelessWidget {
  const BrandsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BrandsCubit(getIt<BrandsRepo>())..getBrands(),
      child: const _BrandsBody(),
    );
  }
}

class _BrandsBody extends StatelessWidget {
  const _BrandsBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandsCubit, BrandsState>(
      builder: (context, state) {
        if (state.status == BrandsStatus.error) {
          return const SizedBox.shrink();
        }

        final isLoading =
            state.status == BrandsStatus.initial ||
            state.status == BrandsStatus.loading;
        final isEmpty = state.status == BrandsStatus.loaded && state.brands.isEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(titleKey: 'brands.title'),
            12.verticalSpace,
            SizedBox(
              height: 100.h,
              child: isLoading
                  ? const BrandsLoading()
                  : isEmpty
                  ? const EmptyDataPlaceholder()
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      itemCount: state.brands.length,
                      separatorBuilder: (_, _) => 16.horizontalSpace,
                      itemBuilder: (_, index) => BrandItem(brand: state.brands[index]),
                    ),
            ),
          ],
        );
      },
    );
  }
}

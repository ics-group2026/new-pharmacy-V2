import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/features/products/presentation/cubits/products_cubit.dart';
import 'package:new_pharmacy_v2/features/products/presentation/cubits/products_state.dart';

import '../../../../../core/widgets/section_header.dart';
import 'trending_filters.dart';
import 'trending_grid.dart';
import 'trending_grid_loading.dart';

class TrendingBody extends StatefulWidget {
  const TrendingBody({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  @override
  State<TrendingBody> createState() => _TrendingBodyState();
}

class _TrendingBodyState extends State<TrendingBody> {
  int _selectedFilter = 0;

  void _selectFilter(int index) {
    if (_selectedFilter == index) return;
    setState(() => _selectedFilter = index);
    context.read<ProductsCubit>().changeCollection(
      trendingFilters[index].collection,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(titleKey: 'trending.title', onSeeAll: widget.onSeeAll),
        12.verticalSpace,
        TrendingFilters(
          selectedIndex: _selectedFilter,
          onSelected: _selectFilter,
        ),
        16.verticalSpace,
        BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            final isLoading =
                state.status == ProductsStatus.initial ||
                state.status == ProductsStatus.loading;

            if (isLoading) return const TrendingGridLoading();
            if (state.status == ProductsStatus.error || state.products.isEmpty) {
              return const SizedBox.shrink();
            }

            return TrendingGrid(
              key: ValueKey(_selectedFilter),
              products: state.products,
            );
          },
        ),
      ],
    );
  }
}

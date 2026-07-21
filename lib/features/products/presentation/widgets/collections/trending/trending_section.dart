import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pharmacy_v2/features/products/data/repos/products_repo.dart';
import 'package:new_pharmacy_v2/features/products/presentation/cubits/products_cubit.dart';

import 'package:new_pharmacy_v2/core/services/setup_service_locator.dart';
import 'trending_body.dart';
import 'trending_filters.dart';

class TrendingSection extends StatelessWidget {
  const TrendingSection({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsCubit(
        getIt<ProductsRepo>(),
        collection: trendingFilters.first.collection,
      )..getProducts(),
      child: TrendingBody(onSeeAll: onSeeAll),
    );
  }
}

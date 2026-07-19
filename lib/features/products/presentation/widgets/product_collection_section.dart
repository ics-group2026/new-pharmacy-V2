import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pharmacy_v2/features/products/presentation/widgets/collection_body.dart';
import '../../../../core/services/setup_service_locator.dart';
import '../../data/repos/products_repo.dart';
import '../cubits/products_cubit.dart';

class ProductCollectionSection extends StatelessWidget {
  const ProductCollectionSection({
    super.key,
    required this.titleKey,
    this.collection,
    this.onSeeAll,
  });

  final String titleKey;

  final String? collection;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProductsCubit(getIt<ProductsRepo>(), collection: collection)
            ..getProducts(),
      child: CollectionBody(titleKey: titleKey, onSeeAll: onSeeAll),
    );
  }
}



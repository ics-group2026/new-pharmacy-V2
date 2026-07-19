import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/core/widgets/section_header.dart';
import 'package:new_pharmacy_v2/features/products/presentation/cubits/products_cubit.dart';
import 'package:new_pharmacy_v2/features/products/presentation/cubits/products_state.dart';
import 'package:new_pharmacy_v2/features/products/presentation/widgets/products_list.dart';
import 'package:new_pharmacy_v2/features/products/presentation/widgets/products_loading.dart';

class CollectionBody extends StatelessWidget {
  const CollectionBody({super.key, required this.titleKey, this.onSeeAll});

  final String titleKey;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
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
            SectionHeader(titleKey: titleKey, onSeeAll: onSeeAll),
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
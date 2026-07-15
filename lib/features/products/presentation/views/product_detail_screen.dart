import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/features/products/data/models/product_model.dart';
import 'package:new_pharmacy_v2/features/products/presentation/widgets/describtion_widget.dart';
import 'package:new_pharmacy_v2/features/products/presentation/widgets/how_to_use_widget.dart';
import 'package:new_pharmacy_v2/features/products/presentation/widgets/product_detail_bottom_bar.dart';
import 'package:new_pharmacy_v2/features/products/presentation/widgets/product_header.dart';
import 'package:new_pharmacy_v2/features/products/presentation/widgets/product_quantity_section.dart';
import 'package:new_pharmacy_v2/features/products/presentation/widgets/product_details_mapper.dart';
import 'package:new_pharmacy_v2/features/products/presentation/widgets/products_sliver_app_bar.dart';

import '../../../../../core/services/setup_service_locator.dart';
import '../../cubit/quantity_cubit.dart';
import '../../data/repos/products_repo.dart';
import '../cubits/product_details_cubit.dart';
import '../cubits/product_details_state.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    // Cards backed by the API carry an id — fetch the full record on open.
    // The hardcoded demo sections have no id, so they render as-is.
    final id = product.id;
    if (id == null) return _ProductDetailContent(product: product);
    return BlocProvider(
      create: (_) => ProductDetailsCubit(getIt<ProductsRepo>())..getProductById(id),
      child: _LiveProductDetail(fallback: product),
    );
  }
}

/// Shows the list data instantly, then swaps in the full record once the
/// details request resolves. On failure it keeps the list data on screen.
class _LiveProductDetail extends StatelessWidget {
  const _LiveProductDetail({required this.fallback});

  final ProductModel fallback;

  @override
  Widget build(BuildContext context) {
    final languageCode = context.locale.languageCode;

    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        final details = state.product;
        if (state.status == ProductDetailsStatus.loaded && details != null) {
          final galleryUrls = details.images
              .map((e) => e.url)
              .whereType<String>()
              .where((url) => url.isNotEmpty)
              .toList();
          final rating = details.averageRating;
          return _ProductDetailContent(
            product: details.toProductModel(languageCode),
            description: details.description?.localized(languageCode),
            galleryUrls: galleryUrls,
            rating: (rating != null && rating > 0) ? rating : null,
          );
        }
        return _ProductDetailContent(product: fallback);
      },
    );
  }
}

class _ProductDetailContent extends StatelessWidget {
  const _ProductDetailContent({
    required this.product,
    this.description,
    this.galleryUrls,
    this.rating,
  });

  final ProductModel product;
  final String? description;
  final List<String>? galleryUrls;
  final double? rating;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider(
      create: (_) => QuantityCubit(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          bottomNavigationBar: ProductDetailBottomBar(product: product),
          body: CustomScrollView(
            slivers: [
              ProductSliverAppBar(product: product, galleryUrls: galleryUrls),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductHeader(product: product, rating: rating),
                        20.verticalSpace,
                        Divider(color: colorScheme.outlineVariant, thickness: 1),
                        20.verticalSpace,
                        DescriptionWidget(
                          colorScheme: colorScheme,
                          theme: theme,
                          description: description,
                        ),
                        20.verticalSpace,
                        HowToUseWidget(colorScheme: colorScheme, theme: theme),
                        20.verticalSpace,
                        ProductQuantitySection(theme: theme, colorScheme: colorScheme),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

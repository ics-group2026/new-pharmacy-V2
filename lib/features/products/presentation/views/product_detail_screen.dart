import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/features/products/presentation/widgets/add_to_cart_bar.dart';
import 'package:new_pharmacy_v2/features/products/presentation/widgets/describtion_widget.dart';
import 'package:new_pharmacy_v2/features/products/presentation/widgets/how_to_use_widget.dart';
import 'package:new_pharmacy_v2/features/products/presentation/widgets/product_header.dart';
import 'package:new_pharmacy_v2/features/products/presentation/widgets/products_sliver_app_bar.dart';
import 'package:new_pharmacy_v2/features/products/presentation/widgets/quantity_widget.dart';

import '../../../../../core/utils/app_translations.dart';
import '../../../cart/cubit/cart_cubit.dart';
import '../../../flash_deals/data/models/flash_deal_model.dart';
import '../../cubit/quantity_cubit.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final FlashDealModel product;

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
          bottomNavigationBar: _BottomBar(product: product),
          body: CustomScrollView(
            slivers: [
              ProductSliverAppBar(product: product),
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
                        ProductHeader(product: product),
                        20.verticalSpace,
                        Divider(color: colorScheme.outlineVariant, thickness: 1),
                        20.verticalSpace,
                        DescriptionWidget(colorScheme: colorScheme, theme: theme),
                        20.verticalSpace,
                        HowToUseWidget(colorScheme: colorScheme, theme: theme),
                        20.verticalSpace,
                        _QuantitySection(theme: theme, colorScheme: colorScheme),
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

class _QuantitySection extends StatelessWidget {
  const _QuantitySection({required this.theme, required this.colorScheme});

  final ThemeData theme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuantityCubit>();
    return BlocBuilder<QuantityCubit, int>(
      builder: (_, quantity) => QuantityWidget(
        quantity: quantity,
        increment: cubit.increment,
        decrement: cubit.decrement,
        theme: theme,
        colorScheme: colorScheme,
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.product});

  final FlashDealModel product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuantityCubit, int>(
      builder: (context, quantity) => AddToCartBar(
        totalPrice: product.price * quantity,
        currency: AppTranslations.t('flash_deals.currency'),
        onAddToCart: () {
          final cart = context.read<CartCubit>();
          for (var i = 0; i < quantity; i++) {
            cart.add(product);
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharamacy_theme_v1/features/products/presentation/widgets/add_to_cart_bar.dart';
import 'package:new_pharamacy_theme_v1/features/products/presentation/widgets/price_row.dart';
import 'package:new_pharamacy_theme_v1/features/products/presentation/widgets/products_sliver_app_bar.dart';
import 'package:new_pharamacy_theme_v1/features/products/presentation/widgets/quantity_widget.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_translations.dart';
import '../../../../../core/widgets/animated_fade_slide.dart';
import '../../../../../core/widgets/discount_badge.dart';
import '../../../../../core/widgets/section_header.dart';
import '../../../../../core/widgets/star_rating_row.dart';
import '../../../cart/cubit/cart_cubit.dart';
import '../../../flash_deals/data/models/flash_deal_model.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final FlashDealModel product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;

  double get _totalPrice => widget.product.price * _quantity;

  void _increment() => setState(() => _quantity++);
  void _decrement() {
    if (_quantity > 1) setState(() => _quantity--);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final product = widget.product;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        bottomNavigationBar: AddToCartBar(
          totalPrice: _totalPrice,
          currency: AppTranslations.t('flash_deals.currency'),
          onAddToCart: () {
            final cart = context.read<CartCubit>();
            for (var i = 0; i < _quantity; i++) {
              cart.add(widget.product);
            }
          },
        ),
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
                      // ── Header info ─────────────────────────────────────
                      AnimatedFadeSlide(
                        delay: Duration.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                if (product.discountPercent != null)
                                  DiscountBadge(percent: product.discountPercent!),
                                const Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryContainer,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.inventory_2_outlined, size: 13.r, color: colorScheme.primary),
                                      4.horizontalSpace,
                                      Text(
                                        AppTranslations.t('product_detail.in_stock'),
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600,
                                          color: colorScheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            12.verticalSpace,
                            Text(
                              product.name,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                                height: 1.3,
                              ),
                            ),
                            if (product.rating != null) ...[
                              10.verticalSpace,
                              Row(
                                children: [
                                  StarRatingRow(rating: product.rating!, size: 16.r),
                                  10.horizontalSpace,
                                  Text(
                                    '(128 ${AppTranslations.t('product_detail.reviews')})',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            16.verticalSpace,
                            PriceRow(product: product),
                          ],
                        ),
                      ),

                      20.verticalSpace,
                      Divider(color: colorScheme.outlineVariant, thickness: 1),
                      20.verticalSpace,

                      // ── Description ─────────────────────────────────────
                      AnimatedFadeSlide(
                        delay: const Duration(milliseconds: 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionHeader(titleKey: 'product_detail.description'),
                            12.verticalSpace,
                            Text(
                              'A premium quality product formulated to support your health and wellness. '
                              'Made with carefully selected ingredients that meet the highest safety standards. '
                              'Suitable for daily use and recommended by healthcare professionals.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurface.withValues(alpha: 0.65),
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),

                      20.verticalSpace,

                      // ── How to Use ──────────────────────────────────────
                      AnimatedFadeSlide(
                        delay: const Duration(milliseconds: 180),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionHeader(titleKey: 'product_detail.how_to_use'),
                            12.verticalSpace,
                            Text(
                              'Take one unit daily with a full glass of water, preferably with a meal. '
                              'Do not exceed the recommended dosage. '
                              'Consult your physician before use if you have any medical conditions.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurface.withValues(alpha: 0.65),
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),

                      20.verticalSpace,

                      QuantityWidget(
                        quantity: _quantity,
                        increment: _increment,
                        decrement: _decrement,
                        theme: theme,
                        colorScheme: colorScheme,
                      ),

                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Sliver AppBar ────────────────────────────────────────────────────────────



// ── Price Row ────────────────────────────────────────────────────────────────



// ── Quantity Stepper ─────────────────────────────────────────────────────────





// ── Add to Cart Bottom Bar ───────────────────────────────────────────────────



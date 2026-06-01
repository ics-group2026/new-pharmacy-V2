import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_translations.dart';
import '../../../../../core/widgets/animated_fade_slide.dart';
import '../../../../../core/widgets/cached_network_image_widget.dart';
import '../../../../../core/widgets/discount_badge.dart';
import '../../../../../core/widgets/section_header.dart';
import '../../../../../core/widgets/star_rating_row.dart';
import '../../../cart/cubit/cart_cubit.dart';
import '../../../flash_deals/data/models/flash_deal_model.dart';
import '../../../wishlist/cubit/wishlist_cubit.dart';

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
        bottomNavigationBar: _AddToCartBar(
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
            _ProductSliverAppBar(product: product),
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
                            _PriceRow(product: product),
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

                      // ── Quantity ─────────────────────────────────────────
                      AnimatedFadeSlide(
                        delay: const Duration(milliseconds: 260),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppTranslations.t('product_detail.quantity'),
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            12.verticalSpace,
                            _QuantityStepper(
                              quantity: _quantity,
                              onIncrement: _increment,
                              onDecrement: _decrement,
                            ),
                          ],
                        ),
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

class _ProductSliverAppBar extends StatelessWidget {
  const _ProductSliverAppBar({required this.product});

  final FlashDealModel product;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 320.h,
      pinned: true,
      backgroundColor: AppColors.primaryDark,
      leading: Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: CircleAvatar(
          backgroundColor: Colors.black26,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18.r),
            onPressed: () => context.pop(),
          ),
        ),
      ),
      actions: [
        BlocSelector<WishlistCubit, List<FlashDealModel>, bool>(
          selector: (state) => state.any((p) => p.imageUrl == product.imageUrl),
          builder: (context, isWishlisted) => Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: CircleAvatar(
              backgroundColor: Colors.black26,
              child: IconButton(
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                  child: Icon(
                    isWishlisted ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    key: ValueKey(isWishlisted),
                    color: isWishlisted ? Colors.redAccent : Colors.white,
                    size: 20.r,
                  ),
                ),
                onPressed: () => context.read<WishlistCubit>().toggle(product),
              ),
            ),
          ),
        ),
      ],
      title: Text(
        product.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'product-image-${product.imageUrl}',
          child: CachedNetworkImageWidget(
            imageUrl: product.imageUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

// ── Price Row ────────────────────────────────────────────────────────────────

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.product});

  final FlashDealModel product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currency = AppTranslations.t('flash_deals.currency');

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${product.price.toStringAsFixed(0)} $currency',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (product.originalPrice != null) ...[
            12.horizontalSpace,
            Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: Text(
                '${product.originalPrice!.toStringAsFixed(0)} $currency',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.4),
                  decoration: TextDecoration.lineThrough,
                  decorationColor: colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
            ),
          ],
          const Spacer(),
          if (product.discountPercent != null)
            Text(
              'Save ${((1 - product.price / product.originalPrice!) * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
            ),
        ],
      ),
    );
  }
}

// ── Quantity Stepper ─────────────────────────────────────────────────────────

class _QuantityStepper extends StatelessWidget {
  const _QuantityStepper({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        _StepButton(
          icon: Icons.remove_rounded,
          onTap: quantity > 1 ? onDecrement : null,
          colorScheme: colorScheme,
        ),
        SizedBox(
          width: 52.w,
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
              child: Text(
                '$quantity',
                key: ValueKey(quantity),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ),
        _StepButton(
          icon: Icons.add_rounded,
          onTap: onIncrement,
          colorScheme: colorScheme,
        ),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onTap, required this.colorScheme});

  final IconData icon;
  final VoidCallback? onTap;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 40.r,
        height: 40.r,
        decoration: BoxDecoration(
          color: enabled ? colorScheme.primary : colorScheme.onSurface.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(
          icon,
          size: 20.r,
          color: enabled ? Colors.white : colorScheme.onSurface.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}

// ── Add to Cart Bottom Bar ───────────────────────────────────────────────────

class _AddToCartBar extends StatelessWidget {
  const _AddToCartBar({
    required this.totalPrice,
    required this.currency,
    required this.onAddToCart,
  });

  final double totalPrice;
  final String currency;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 12.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppTranslations.t('product_detail.total'),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                4.verticalSpace,
                Text(
                  '${totalPrice.toStringAsFixed(0)} $currency',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
            16.horizontalSpace,
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: ElevatedButton(
                  onPressed: onAddToCart,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                  ),
                  child: Text(
                    AppTranslations.t('product_detail.add_to_cart'),
                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
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

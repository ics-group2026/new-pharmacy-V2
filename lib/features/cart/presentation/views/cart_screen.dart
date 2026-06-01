import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_translations.dart';
import '../../../../../core/widgets/animated_fade_slide.dart';
import '../../../../../core/widgets/cached_network_image_widget.dart';
import '../../../../../core/widgets/t_text.dart';
import '../../../flash_deals/data/models/flash_deal_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final List<_CartEntry> _cartItems = [
    _CartEntry(
      product: const FlashDealModel(
        name: 'Organic High-Curcumin Turmeric Powder',
        price: 22.49,
        originalPrice: 32.0,
        discountPercent: 30,
        imageUrl: 'https://picsum.photos/seed/ct1/300/300',
        rating: 4.5,
      ),
    ),
    _CartEntry(
      product: const FlashDealModel(
        name: 'Vitamin C 1000mg Effervescent Tablets',
        price: 89.0,
        originalPrice: 115.0,
        discountPercent: 23,
        imageUrl: 'https://picsum.photos/seed/ct2/300/300',
        rating: 5.0,
      ),
    ),
    _CartEntry(
      product: const FlashDealModel(
        name: 'Omega 3 Fish Oil 1200mg Softgels',
        price: 145.0,
        originalPrice: 190.0,
        discountPercent: 24,
        imageUrl: 'https://picsum.photos/seed/ct3/300/300',
        rating: 4.5,
      ),
    ),
  ];

  double get _subtotal =>
      _cartItems.fold(0, (sum, e) => sum + e.product.price * e.quantity);

  void _increment(int index) => setState(() => _cartItems[index].quantity++);

  void _decrement(int index) {
    if (_cartItems[index].quantity > 1) {
      setState(() => _cartItems[index].quantity--);
    }
  }

  void _remove(int index) => setState(() => _cartItems.removeAt(index));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currency = AppTranslations.t('flash_deals.currency');

    return Scaffold(
      appBar: AppBar(
        title: const TText('nav_bar.cart'),
        actions: [
          if (_cartItems.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    '${_cartItems.length}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: _cartItems.isEmpty
          ? null
          : _CheckoutBar(subtotal: _subtotal, currency: currency),
      body: _cartItems.isEmpty
          ? _CartEmptyState()
          : AnimatedFadeSlide(
              delay: Duration.zero,
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _CartItemRow(
                        entry: _cartItems[index],
                        currency: currency,
                        onIncrement: () => _increment(index),
                        onDecrement: () => _decrement(index),
                        onRemove: () => _remove(index),
                      ),
                      childCount: _cartItems.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
                      child: _OrderSummary(subtotal: _subtotal, currency: currency),
                    ),
                  ),
                  SliverPadding(padding: EdgeInsets.only(bottom: 100.h)),
                ],
              ),
            ),
    );
  }
}

// ── Internal model ────────────────────────────────────────────────────────────

class _CartEntry {
  _CartEntry({required this.product, this.quantity = 1});

  final FlashDealModel product;
  int quantity;
}

// ── Cart item row ─────────────────────────────────────────────────────────────

class _CartItemRow extends StatelessWidget {
  const _CartItemRow({
    required this.entry,
    required this.currency,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  final _CartEntry entry;
  final String currency;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Dismissible(
      key: ValueKey(entry.product.imageUrl),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onRemove(),
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        padding: EdgeInsetsDirectional.only(end: 24.w),
        color: AppColors.error,
        child: Icon(Icons.delete_outline_rounded, color: Colors.white, size: 26.r),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedNetworkImageWidget(
                imageUrl: entry.product.imageUrl,
                width: 72.r,
                height: 72.r,
                fit: BoxFit.cover,
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                      height: 1.35,
                    ),
                  ),
                  6.verticalSpace,
                  Text(
                    '${(entry.product.price * entry.quantity).toStringAsFixed(0)} $currency',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      _StepBtn(
                        icon: Icons.remove_rounded,
                        enabled: entry.quantity > 1,
                        onTap: onDecrement,
                      ),
                      SizedBox(
                        width: 36.w,
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 180),
                            transitionBuilder: (child, anim) =>
                                FadeTransition(opacity: anim, child: child),
                            child: Text(
                              '${entry.quantity}',
                              key: ValueKey(entry.quantity),
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                      ),
                      _StepBtn(
                        icon: Icons.add_rounded,
                        enabled: true,
                        onTap: onIncrement,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: onRemove,
                        icon: Icon(
                          Icons.delete_outline_rounded,
                          size: 20.r,
                          color: colorScheme.onSurface.withValues(alpha: 0.4),
                        ),
                        tooltip: AppTranslations.t('cart.remove'),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepBtn extends StatelessWidget {
  const _StepBtn({required this.icon, required this.enabled, required this.onTap});

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 28.r,
        height: 28.r,
        decoration: BoxDecoration(
          color: enabled
              ? colorScheme.primary
              : colorScheme.onSurface.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          icon,
          size: 16.r,
          color: enabled ? Colors.white : colorScheme.onSurface.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}

// ── Order summary ─────────────────────────────────────────────────────────────

class _OrderSummary extends StatelessWidget {
  const _OrderSummary({required this.subtotal, required this.currency});

  final double subtotal;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TText(
            'cart.order_summary',
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          12.verticalSpace,
          _SummaryRow(
            labelKey: 'cart.subtotal',
            value: '${subtotal.toStringAsFixed(0)} $currency',
          ),
          8.verticalSpace,
          _SummaryRow(
            labelKey: 'cart.delivery_fee',
            valueKey: 'cart.free',
            valueColor: AppColors.success,
          ),
          12.verticalSpace,
          Divider(color: colorScheme.outlineVariant, thickness: 1),
          12.verticalSpace,
          _SummaryRow(
            labelKey: 'cart.total',
            value: '${subtotal.toStringAsFixed(0)} $currency',
            bold: true,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.labelKey,
    this.value,
    this.valueKey,
    this.bold = false,
    this.valueColor,
  });

  final String labelKey;
  final String? value;
  final String? valueKey;
  final bool bold;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final style = theme.textTheme.bodyMedium?.copyWith(
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      color: bold ? colorScheme.primary : colorScheme.onSurface,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TText(labelKey, style: style),
        valueKey != null
            ? TText(
                valueKey!,
                style: style?.copyWith(color: valueColor ?? colorScheme.primary),
              )
            : Text(value ?? '', style: style?.copyWith(color: valueColor)),
      ],
    );
  }
}

// ── Checkout bar ──────────────────────────────────────────────────────────────

class _CheckoutBar extends StatelessWidget {
  const _CheckoutBar({required this.subtotal, required this.currency});

  final double subtotal;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
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
        child: SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            child: TText(
              'cart.checkout',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _CartEmptyState extends StatelessWidget {
  const _CartEmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100.r,
            height: 100.r,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 48.r,
              color: colorScheme.primary.withValues(alpha: 0.6),
            ),
          ),
          24.verticalSpace,
          TText(
            'cart.empty_title',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          10.verticalSpace,
          TText(
            'cart.empty_subtitle',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

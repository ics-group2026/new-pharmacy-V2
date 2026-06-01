import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../routes/app_routes.dart';
import '../utils/app_translations.dart';
import 'cached_network_image_widget.dart';
import 'discount_badge.dart';
import 'star_rating_row.dart';
import '../../features/flash_deals/data/models/flash_deal_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.imageHeight,
    this.width,
  });

  final FlashDealModel product;
  final double? imageHeight;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final imgHeight = imageHeight ?? 130.h;

    Widget card = Container(
      width: width,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Hero(
                tag: 'product-image-${product.imageUrl}',
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                  child: CachedNetworkImageWidget(
                    imageUrl: product.imageUrl,
                    width: double.infinity,
                    height: imgHeight,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: _WishlistButton(surface: colorScheme.surface, onSurface: colorScheme.onSurface),
              ),
              if (product.discountPercent != null)
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: DiscountBadge(percent: product.discountPercent!),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                    height: 1.35,
                  ),
                ),
                if (product.rating != null) ...[
                  6.verticalSpace,
                  StarRatingRow(rating: product.rating!),
                ],
                8.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${product.price.toStringAsFixed(0)} ${AppTranslations.t('flash_deals.currency')}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (product.originalPrice != null) ...[
                      6.horizontalSpace,
                      Text(
                        product.originalPrice!.toStringAsFixed(0),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.38),
                          decoration: TextDecoration.lineThrough,
                          decorationColor: colorScheme.onSurface.withValues(alpha: 0.38),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 12.h),
            child: SizedBox(
              width: double.infinity,
              height: 34.h,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  AppTranslations.t('flash_deals.buy_now'),
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: () => context.push(AppRoutes.productDetail, extra: product),
      child: card,
    );
  }
}

class _WishlistButton extends StatelessWidget {
  const _WishlistButton({required this.surface, required this.onSurface});

  final Color surface;
  final Color onSurface;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.r),
      decoration: BoxDecoration(
        color: surface.withValues(alpha: 0.92),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        Icons.favorite_border_rounded,
        size: 15.r,
        color: onSurface.withValues(alpha: 0.45),
      ),
    );
  }
}

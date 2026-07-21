import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../routes/app_routes.dart';
import '../utils/app_translations.dart';
import 'cached_network_image_widget.dart';
import 'discount_badge.dart';
import 'package:new_pharmacy_v2/features/products/data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.imageHeight,
    this.width,
    this.enableHero = true,
  });

  final ProductModel product;
  final double? imageHeight;
  final double? width;
  final bool enableHero;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final imgHeight = imageHeight ?? 130.h;

    final imageUrl = product.image?.url ?? '';
    final heroTag = 'product-image-${product.id ?? imageUrl}';
    final price = product.sellingPrice ?? product.price ?? 0;
    final originalPrice = product.hasDiscount ? product.price : null;
    final discountPercent = product.discountPercent;

    return GestureDetector(
      onTap: () => context.push(AppRoutes.productDetail, extra: product),
      child: Container(
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
                _ProductImage(
                  heroTag: enableHero ? heroTag : null,
                  imageUrl: imageUrl,
                  height: imgHeight,
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  // Wishlist cubit was removed; the button stays for the UI
                  // shell but doesn't toggle anything yet.
                  child: _WishlistButton(isWishlisted: false, onTap: () {}),
                ),
                if (discountPercent != null)
                  Positioned(
                    top: 8.h,
                    left: 8.w,
                    child: DiscountBadge(percent: discountPercent),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fixed height reserves room for 2 lines regardless of the
                  // actual name length, so every grid card lands at the same
                  // height instead of leaving a gap under short names.
                  SizedBox(
                    height: 33,
                    child: Text(
                      product.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                        height: 1.35,
                      ),
                    ),
                  ),
                  8.verticalSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${price.toStringAsFixed(0)} ${AppTranslations.t('flash_deals.currency')}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (originalPrice != null) ...[
                        6.horizontalSpace,
                        Text(
                          originalPrice.toStringAsFixed(0),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.38),
                            decoration: TextDecoration.lineThrough,
                            decorationColor: colorScheme.onSurface.withValues(
                              alpha: 0.38,
                            ),
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
                  onPressed: () =>
                      context.push(AppRoutes.productDetail, extra: product),
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
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.heroTag, required this.imageUrl, required this.height});

  final Object? heroTag;
  final String imageUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    final image = ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      child: CachedNetworkImageWidget(
        imageUrl: imageUrl,
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
      ),
    );

    if (heroTag == null) return image;
    return Hero(tag: heroTag!, child: image);
  }
}

class _WishlistButton extends StatelessWidget {
  const _WishlistButton({required this.isWishlisted, required this.onTap});

  final bool isWishlisted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6.r),
        decoration: BoxDecoration(
          color: colorScheme.surface.withValues(alpha: 0.92),
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
          isWishlisted ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          size: 15.r,
          color: isWishlisted
              ? Colors.redAccent
              : colorScheme.onSurface.withValues(alpha: 0.45),
        ),
      ),
    );
  }
}

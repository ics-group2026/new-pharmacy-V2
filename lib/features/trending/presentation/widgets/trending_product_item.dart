import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_translations.dart';
import '../../../../../core/widgets/cached_network_image_widget.dart';
import '../../../flash_deals/data/models/flash_deal_model.dart';

class TrendingProductItem extends StatelessWidget {
  const TrendingProductItem({super.key, required this.product});

  final FlashDealModel product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: CachedNetworkImageWidget(
                  imageUrl: product.imageUrl,
                  width: double.infinity,
                  height: 110.h,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.all(5.r),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.favorite_border_rounded,
                    size: 14.r,
                    color: colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                ),
              ),
              if (product.discountPercent != null)
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC107),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      '${product.discountPercent}% Off',
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 8.h),
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
                      height: 1.3,
                    ),
                  ),
                  if (product.rating != null) ...[
                    4.verticalSpace,
                    _StarRating(rating: product.rating!),
                  ],
                  4.verticalSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${product.price.toStringAsFixed(0)} ${AppTranslations.t('flash_deals.currency')}',
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (product.originalPrice != null) ...[
                        4.horizontalSpace,
                        Text(
                          product.originalPrice!.toStringAsFixed(0),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.4),
                            decoration: TextDecoration.lineThrough,
                            decorationColor: colorScheme.onSurface.withValues(alpha: 0.4),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 28.h,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        AppTranslations.t('flash_deals.buy_now'),
                        style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StarRating extends StatelessWidget {
  const _StarRating({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    const starColor = Color(0xFFFFC107);
    final emptyColor = Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2);

    return Row(
      children: [
        ...List.generate(5, (i) {
          if (i < rating.floor()) {
            return Icon(Icons.star_rounded, color: starColor, size: 11.r);
          } else if (i < rating) {
            return Icon(Icons.star_half_rounded, color: starColor, size: 11.r);
          }
          return Icon(Icons.star_rounded, color: emptyColor, size: 11.r);
        }),
        3.horizontalSpace,
        Text(
          rating.toString(),
          style: TextStyle(
            fontSize: 10.sp,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

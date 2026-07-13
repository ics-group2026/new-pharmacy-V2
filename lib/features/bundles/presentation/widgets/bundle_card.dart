import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/app_translations.dart';
import '../../../../core/widgets/cached_network_image_widget.dart';
import '../../../../core/widgets/discount_badge.dart';
import '../../data/models/bundle_model.dart';

class BundleCard extends StatelessWidget {
  const BundleCard({
    super.key,
    required this.bundle,
    this.width,
    this.imageHeight,
  });

  final BundleModel bundle;
  final double? width;
  final double? imageHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final imgHeight = imageHeight ?? 140.h;
    final currency = AppTranslations.t('flash_deals.currency');
    final discountPercent = bundle.savingsPercentage.round();
    final hasDiscount = bundle.originalPrice > bundle.bundlePrice;

    return GestureDetector(
      onTap: () => context.push(AppRoutes.bundleDetail, extra: bundle),
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
                Hero(
                  tag: 'bundle-image-${bundle.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.r),
                    ),
                    child: CachedNetworkImageWidget(
                      imageUrl: bundle.image,
                      width: double.infinity,
                      height: imgHeight,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (hasDiscount && discountPercent > 0)
                  Positioned(
                    top: 8.h,
                    left: 8.w,
                    child: DiscountBadge(percent: discountPercent),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bundle.title,
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
                    bundle.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      Text(
                        '${bundle.bundlePrice.toStringAsFixed(0)} $currency',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (hasDiscount) ...[
                        6.horizontalSpace,
                        Expanded(
                          child: Text(
                            bundle.originalPrice.toStringAsFixed(0),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurface.withValues(
                                alpha: 0.5,
                              ),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                      ],
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

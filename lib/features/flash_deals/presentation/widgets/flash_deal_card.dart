import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_translations.dart';
import '../../../../core/widgets/cached_network_image_widget.dart';
import '../../data/models/flash_deal_model.dart';
import 'flash_deal_countdown.dart';

class FlashDealCard extends StatelessWidget {
  const FlashDealCard({
    super.key,
    required this.flashDeal,
    this.width,
    this.imageHeight,
  });

  final FlashDealModel flashDeal;
  final double? width;
  final double? imageHeight;

  /// Cheapest discounted price across the deal's products, if any are priced.
  double? get _lowestPrice {
    final prices = flashDeal.products
        .map((p) => p.discountedPrice)
        .whereType<double>();
    if (prices.isEmpty) return null;
    return prices.reduce((a, b) => a < b ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final imgHeight = imageHeight ?? 130.h;
    final endsAt = flashDeal.endsAt;
    final lowestPrice = _lowestPrice;
    final productCount = flashDeal.products.length;

    return GestureDetector(
      onTap: () => context.push(AppRoutes.flashDealDetail, extra: flashDeal),
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
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              child: Stack(
                children: [
                  Hero(
                    tag: 'flash-deal-image-${flashDeal.id}',
                    child: CachedNetworkImageWidget(
                      imageUrl: flashDeal.image,
                      width: double.infinity,
                      height: imgHeight,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Scrim so the countdown stays legible over any image.
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.35),
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.25),
                          ],
                          stops: const [0, 0.5, 1],
                        ),
                      ),
                    ),
                  ),
                  if (endsAt != null)
                    Positioned(
                      top: 8.h,
                      left: 8.w,
                      child: FlashDealCountdown(endsAt: endsAt, onSurface: true),
                    ),
                  if (productCount > 0)
                    Positioned(
                      bottom: 8.h,
                      left: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.flash,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          productCount == 1
                              ? AppTranslations.t('flash_deals.one_item')
                              : AppTranslations.t(
                                  'flash_deals.items',
                                  namedArgs: {'count': '$productCount'},
                                ),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    flashDeal.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                      height: 1.35,
                    ),
                  ),
                  6.verticalSpace,
                  if (lowestPrice != null)
                    Row(
                      children: [
                        Text(
                          '${AppTranslations.t('flash_deals.from')} ',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '${lowestPrice.toStringAsFixed(0)} '
                            '${AppTranslations.t('flash_deals.currency')}',
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.flash,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      flashDeal.description ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
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

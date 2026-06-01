import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_translations.dart';
import '../../../../../core/widgets/cached_network_image_widget.dart';
import '../../data/models/flash_deal_model.dart';

class FlashDealItem extends StatelessWidget {
  const FlashDealItem({super.key, required this.deal});

  final FlashDealModel deal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: 155.w,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 10,
            offset: const Offset(0, 3),
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
                  imageUrl: deal.imageUrl,
                  width: double.infinity,
                  height: 145.h,
                  fit: BoxFit.cover,
                ),
              ),
              if (deal.discountPercent != null)
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC107),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      '${deal.discountPercent}% Off',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deal.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                    height: 1.3,
                  ),
                ),
                6.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${deal.price.toStringAsFixed(0)} ${AppTranslations.t('flash_deals.currency')}',
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (deal.originalPrice != null) ...[
                      5.horizontalSpace,
                      Text(
                        deal.originalPrice!.toStringAsFixed(0),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.4),
                          decoration: TextDecoration.lineThrough,
                          decorationColor: colorScheme.onSurface.withValues(alpha: 0.4),
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
    );
  }
}

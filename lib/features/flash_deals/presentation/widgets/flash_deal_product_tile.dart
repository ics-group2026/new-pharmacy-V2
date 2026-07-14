import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_translations.dart';
import '../../../../core/widgets/cached_network_image_widget.dart';
import '../../data/models/flash_deal_product.dart';

class FlashDealProductTile extends StatelessWidget {
  const FlashDealProductTile({super.key, required this.dealProduct});

  final FlashDealProduct dealProduct;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final price = dealProduct.discountedPrice;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          CachedNetworkImageWidget(
            imageUrl: dealProduct.product?.image,
            width: 52.w,
            height: 52.w,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(12.r),
          ),
          12.horizontalSpace,
          Expanded(
            child: Text(
              dealProduct.product?.name ?? '',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          if (price != null) ...[
            8.horizontalSpace,
            Text(
              '${price.toStringAsFixed(0)} '
              '${AppTranslations.t('flash_deals.currency')}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.flash,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

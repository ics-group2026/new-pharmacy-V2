import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/widgets/cached_network_image_widget.dart';
import '../../../../core/widgets/discount_badge.dart';
import '../../data/models/combo_offer_model.dart';

class ComboOfferCard extends StatelessWidget {
  const ComboOfferCard({
    super.key,
    required this.comboOffer,
    this.width,
    this.imageHeight,
  });

  final ComboOfferModel comboOffer;
  final double? width;
  final double? imageHeight;

  int? get _discountPercent {
    if (comboOffer.buyQuantity <= 0 || comboOffer.payQuantity >= comboOffer.buyQuantity) {
      return null;
    }
    return (((comboOffer.buyQuantity - comboOffer.payQuantity) / comboOffer.buyQuantity) * 100)
        .round();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final imgHeight = imageHeight ?? 140.h;
    final discountPercent = _discountPercent;

    return GestureDetector(
      onTap: () => context.push(AppRoutes.comboOfferDetail, extra: comboOffer),
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
                  tag: 'combo-offer-image-${comboOffer.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                    child: CachedNetworkImageWidget(
                      imageUrl: comboOffer.image,
                      width: double.infinity,
                      height: imgHeight,
                      fit: BoxFit.cover,
                    ),
                  ),
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
              padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comboOffer.title,
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
                    comboOffer.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    comboOffer.offerDetails,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
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

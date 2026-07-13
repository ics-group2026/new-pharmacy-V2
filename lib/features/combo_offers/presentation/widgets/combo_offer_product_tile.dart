import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/cached_network_image_widget.dart';
import '../../data/models/combo_offer_product.dart';

class ComboOfferProductTile extends StatelessWidget {
  const ComboOfferProductTile({super.key, required this.comboProduct});

  final ComboOfferProduct comboProduct;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final image = comboProduct.product.image;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: image != null
                ? CachedNetworkImageWidget(
                    imageUrl: image,
                    width: 52.w,
                    height: 52.w,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 52.w,
                    height: 52.w,
                    color: colorScheme.surfaceContainerHighest,
                    child: Icon(
                      Icons.medication_outlined,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Text(
              comboProduct.product.name,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          Text(
            'x${comboProduct.quantity}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

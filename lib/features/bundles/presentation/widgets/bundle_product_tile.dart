import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/cached_network_image_widget.dart';
import '../../data/models/bundle_product.dart';

class BundleProductTile extends StatelessWidget {
  const BundleProductTile({super.key, required this.bundleProduct});

  final BundleProduct bundleProduct;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final image = bundleProduct.product.image;

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
              bundleProduct.product.name,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          Text(
            'x${bundleProduct.quantity}',
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

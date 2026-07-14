import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/cached_network_image_widget.dart';
import '../../data/models/flash_deal_model.dart';
import 'flash_deal_countdown.dart';

class FlashDealDetailAppBar extends StatelessWidget {
  const FlashDealDetailAppBar({super.key, required this.flashDeal});

  final FlashDealModel flashDeal;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final endsAt = flashDeal.endsAt;

    return SliverAppBar(
      pinned: true,
      expandedHeight: 260.h,
      backgroundColor: colorScheme.surface,
      leading: Padding(
        padding: EdgeInsets.all(8.r),
        child: CircleAvatar(
          backgroundColor: Colors.black.withValues(alpha: 0.35),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 18,
            ),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ),
      ),
      actions: [
        if (endsAt != null)
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Center(
              child: FlashDealCountdown(endsAt: endsAt, onSurface: true),
            ),
          ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'flash-deal-image-${flashDeal.id}',
          child: CachedNetworkImageWidget(
            imageUrl: flashDeal.image,
            width: double.infinity,
            height: 260.h,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/cached_network_image_widget.dart';
import '../../data/models/combo_offer_model.dart';

class ComboOfferDetailAppBar extends StatelessWidget {
  const ComboOfferDetailAppBar({super.key, required this.comboOffer});

  final ComboOfferModel comboOffer;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'combo-offer-image-${comboOffer.id}',
          child: CachedNetworkImageWidget(
            imageUrl: comboOffer.image,
            width: double.infinity,
            height: 260.h,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
